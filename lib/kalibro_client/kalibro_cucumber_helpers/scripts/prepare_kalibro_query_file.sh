#!/bin/bash

# This file is part of KalibroClient
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

PSQLFILE=$1
QUERYFILE=$2

if ! [ -f $PSQLFILE ]
  then wget https://raw.github.com/mezuro/kalibro/kalibro-dev/KalibroCore/src/META-INF/PostgreSQL.sql -O $PSQLFILE
fi

DROPLIMIT="END OF DROP TABLES"
RANGE=$(grep -n "$DROPLIMIT" $PSQLFILE | cut -d":" -f1)
START=1
END=$(($RANGE - 1))
CUT=$START,$END\!d
REPLACE="s/DROP TABLE IF EXISTS sequences,/TRUNCATE/"

if [ -f $QUERYFILE ]
  then sudo rm $QUERYFILE
fi

sed -e "$CUT" -e "$REPLACE" $PSQLFILE > $QUERYFILE
sudo chown postgres.postgres $QUERYFILE
