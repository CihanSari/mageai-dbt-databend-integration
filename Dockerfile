# Customize
ARG MDD_BASE_IMAGE=mageai/mageai:latest
ARG MDD_PYTHON_VERSION=python3.11
ARG MDD_VENV_PATH=/db/venv

# Base image for MageAI and dbt
FROM $MDD_BASE_IMAGE as mdd
ARG MDD_PYTHON_VERSION
ARG MDD_VENV_PATH

# Create a virtual env
RUN apt-get update && \
    apt-get install -y $MDD_PYTHON_VERSION $MDD_PYTHON_VERSION-venv
RUN $MDD_PYTHON_VERSION -m venv $MDD_VENV_PATH
RUN echo -e '#!/bin/bash\n\nsource $MDD_VENV_PATH/bin/activate\npip install dbt-databend-cloud\n' > $MDD_VENV_PATH/install-dependencies.sh
RUN bash $MDD_VENV_PATH/install-dependencies.sh

# Create a shell script to execute dbt in the new environment
RUN echo -e '#!/bin/bash\n\nsource $MDD_VENV_PATH/bin/activate\n$MDD_VENV_PATH/bin/dbt "$@"\n' > /usr/local/bin/dbt
RUN chmod +x /usr/local/bin/dbt

# Intermediate stage for testing
FROM mdd as mdd-test
COPY test.sh test.sh
RUN bash test.sh
