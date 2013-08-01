#!/bin/bash

KALIBRO_HOME=$1
TOMCAT_RESTART_COMMAND=$2

echo "-->  Removing tests directory"
sudo rm -rf $KALIBRO_HOME/tests

# you must restart tomcat6
$TOMCAT_RESTART_COMMAND