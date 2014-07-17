#!/bin/bash

echo Configuring WebADM
bash /opt/webadm/bin/setup

echo Configuring Slapd
bash /opt/slapd/bin/setup
sed -i.bak 's/export USER="slapd"/export USER="root"/i' /opt/slapd/bin/slapd

echo Configuring Radiusd
bash /opt/radiusd/bin/setup
