#!/bin/bash

# shutting down services

sudo service warden stop
sudo service tree stop
sudo service update stop
sudo service redirect stop

# deleting services

sudo rm -rf /etc/init.d/warden
sudo rm -rf /etc/init.d/tree
sudo rm -rf /etc/init.d/update
sudo rm -rf /etc/init.d/redirect

# deleting repository

sudo rm -rf /home/dom/services/
