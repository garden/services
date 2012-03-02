#!/bin/bash

# clone repositories

git clone http://github.com/garden/tree /home/dom/tree;
git clone http://github.com/garden/services /home/dom/services;

# generate HTTPS credentials

cd /home/dom/tree && make https;
openssl rsa -in /home/dom/tree/https.key -out /home/dom/tree/https.key.new;
mv /home/dom/tree/https.key{.new,};

# install service scripts

sudo cp /home/dom/services/tree /etc/init.d/;
sudo cp /home/dom/services/update /etc/init.d/;
sudo cp /home/dom/services/warden /etc/init.d/;
sudo cp /home/dom/services/redirect /etc/init.d/;

# start all services

sudo service redirect start;
sudo service warden start;
#sudo service update start;
