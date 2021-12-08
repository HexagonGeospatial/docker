#!/bin/bash

# ENTRYPOINT for sample Dockerfile running APOLLO Essentials in a Docker on CentOS
# Copyright 2021 Hexagon AB and/or its subsidiaries and affiliates. All rights reserved.

httpd

/usr/local/hexagon/erdas-apollo/bin/iwsctl start

exec /usr/sbin/init &

# Dynamically print server logs to host terminal
tail -F /usr/local/hexagon/erdas-apollo/log/APOLLOCore.log
