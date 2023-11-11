#!/bin/bash
dbt_version_output=$(dbt --version)

# Check if databend plugin is listed as incompatible
if [[ $dbt_version_output =~ "Plugins:" ]]; then
    plugins_section=$(echo "$dbt_version_output" | awk '/Plugins:/,/At least one plugin/')
    if [[ $plugins_section =~ "databend" && $plugins_section =~ "Not compatible" ]]; then
        >&2 echo "Databend plugin is listed as incompatible.\n$dbt_version_output";
        exit 1
    else
        echo "Databend plugin is either up to date or compatible.\n$dbt_version_output"
        exit 0
    fi
else
    >&2 echo "Unable to determine plugin compatibility information.\n$dbt_version_output"
    exit 2
fi
