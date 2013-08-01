#!/bin/bash

PASSWORD=$1
DATABASE=$2
QUERYFILE=$3

sudo su postgres -c "export PGPASSWORD=$PASSWORD && psql -q -d $DATABASE -f $QUERYFILE"