# MageAI - dbt - Databend Integration

## Integration Overview

This project integrates MageAI with dbt and the Databend plugin. However, due to version incompatibility issues, a temporary solution has been implemented by creating an isolated virtual environment for dbt and Databend.

## Temporary Solution

To address the version mismatch, a virtual Python 3.11 environment is created specifically for dbt and Databend. This allows the installation of dependencies without affecting the MageAI environment.

## Build Instructions

To build the Docker image, use the following command:

```bash
docker build --target mdd --build-arg MDD_BASE_IMAGE=mageai/mageai:latest --build-arg MDD_PYTHON_VERSION=python3.11 -t mageai-dbt-databend .
```

## Test Instructions

Run the included test script to validate the integration:

```bash
docker build --target mdd-test --build-arg MDD_BASE_IMAGE=mageai/mageai:latest --build-arg MDD_PYTHON_VERSION=python3.11 -t mageai-dbt-databend .
```

Databend dbt cloud docs can be found [here](https://github.com/databendcloud/dbt-databend/wiki/How-to-use-dbt-with-Databend-Cloud#configuring-project) for project details.
