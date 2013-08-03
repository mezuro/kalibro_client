#!/bin/bash

# This file is part of KalibroEntities
# Copyright (C) 2013  it's respectives authors (please see the AUTHORS file)
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

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