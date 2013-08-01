#!/bin/bash

# where are your .kalibro dir?
KALIBRO_HOME=$1

TOMCAT_RESTART_COMMAND=$2
TOMCAT_USER=$3
TOMCAT_GROUP=$4

# create a kalibro test dir
echo "-->  Creating tests directory"
sudo mkdir $KALIBRO_HOME/tests
echo "-->  Copying test settings"
sudo cp $KALIBRO_HOME/kalibro_test.settings $KALIBRO_HOME/tests/kalibro.settings
echo "-->  Changing owner of tests directory to tomcat6"
sudo chown -R $TOMCAT_USER:$TOMCAT_GROUP $KALIBRO_HOME/tests

# you must restart tomcat6
$TOMCAT_RESTART_COMMAND