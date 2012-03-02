#!/bin/bash

cd /home/dom/tree >> /home/dom/services/update.log 2>&1
git pull origin master >> /home/dom/services/update.log 2>&1
sudo service tree restart >> /home/dom/services/update.log 2>&1
