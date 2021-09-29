#!/usr/bin/env bash

SCRIPT_DIR=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)

SCHEDULER_PID_FILE=${SCRIPT_DIR}/.airflow/airflow-scheduler.pid
WEBSERVER_PID_FILE=${SCRIPT_DIR}/.airflow/airflow-webserver-monitor.pid

declare -a file_names=("$SCHEDULER_PID_FILE" "$WEBSERVER_PID_FILE")

for file in "${file_names[@]}"; do
  if [[ -f "$file" ]]; then
      kill "$(cat $file)"
  fi
done
