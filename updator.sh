#!/bin/bash

cd /home/dom/tree >> /home/dom/services/update.log 2>&1
make backup >> /home/dom/services/update.log 2>&1
git pull origin master >> /home/dom/services/update.log 2>&1
systemctl stop tree.service >> /home/dom/services/update.log 2>&1
