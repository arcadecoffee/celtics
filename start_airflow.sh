#!/usr/bin/env bash

# airflow needs a home, ~/airflow is the default,
# but you can lay foundation somewhere else if you prefer
# (optional)

SCRIPT_DIR=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)

mkdir -p ${SCRIPT_DIR}/dags
mkdir -p ${SCRIPT_DIR}/plugins

export AIRFLOW_HOME=${SCRIPT_DIR}/.airflow
export AIRFLOW__CORE__DAGS_FOLDER=${SCRIPT_DIR}/dags
export AIRFLOW__CORE__LOAD_EXAMPLES=False
export AIRFLOW__CORE__PLUGINS_FOLDER=${SCRIPT_DIR}/plugins
export AIRFLOW__WEBSERVER__DAG_DEFAULT_VIEW=graph
export AIRFLOW__WEBSERVER__EXPOSE_CONFIG=True

AIRFLOW_VERSION=2.0.1
PYTHON_VERSION="$(python --version | cut -d " " -f 2 | cut -d "." -f 1-2)"
# For example: 3.6
CONSTRAINT_URL="https://raw.githubusercontent.com/apache/airflow/constraints-${AIRFLOW_VERSION}/constraints-${PYTHON_VERSION}.txt"
# For example: https://raw.githubusercontent.com/apache/airflow/constraints-2.1.4/constraints-3.6.txt
pip install "apache-airflow==${AIRFLOW_VERSION}" --constraint "${CONSTRAINT_URL}"

## initialize the database
airflow db init

airflow users create \
    --username admin \
    --password admin \
    --firstname Peter \
    --lastname Parker \
    --role Admin \
    --email spiderman@superhero.org

# start the web server, default port is 8080
airflow webserver --port 8080 -D

# start the scheduler
# open a new terminal or else run webserver with ``-D`` option to run it as a daemon
airflow scheduler -D

# visit localhost:8080 in the browser and use the admin account you just
# created to login. Enable the example_bash_operator dag in the home page