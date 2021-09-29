#!/usr/bin/env bash

kill $(cat .airflow/airflow-scheduler.pid)
kill $(cat .airflow/airflow-webserver-monitor.pid)