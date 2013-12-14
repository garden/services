#!/bin/bash

# Package manager.
if ! which apt-get > /dev/null;
  then PM=ubuntu;
elif ! which nix-env > /dev/null;
  then PM=nix;
fi

# Make sure you have all we need
if ! which git > /dev/null;
  then echo "Git is not installed. Installation of git in progress.";
  case $PM in
    ubuntu)
      sudo apt-get install git-core;;
    nix)
      sudo nix-env -i git;;
  esac
  echo "Installation of git done.";
fi;

if ! which node > /dev/null;
  then echo "Node is not installed. Installation of Node in progress.";
  case $PM in
    ubuntu)
      sudo apt-get install nodejs;;
    nix)
      sudo nix-env -i nodejs;;
  esac
  echo "Installation of Node done.";
fi;

if ! which openssl > /dev/null;
  then echo "openssl is not installed. Installation of openssl in progress.";
  case $PM in
    ubuntu)
      sudo apt-get install openssl;;
    nix)
      sudo nix-env -i openssl;;
  esac
  echo "Installation of openssl done.";
fi;

# clone repositories

git clone http://github.com/garden/tree /home/dom/tree
git clone http://github.com/garden/services /home/dom/services

# generate HTTPS credentials

cd /home/dom/tree
openssl genrsa -aes256 -out https.key 1024
openssl req -new -nodes -key https.key -out https.csr
openssl x509 -req -days 365 -in https.csr -signkey https.key -out https.crt
cp https.key{,.orig}
openssl rsa -in https.key.orig -out https.key

# install service scripts

sudo cp /home/dom/services/tree /etc/init.d/
sudo cp /home/dom/services/update /etc/init.d/
sudo cp /home/dom/services/warden /etc/init.d/
sudo cp /home/dom/services/redirect /etc/init.d/

# start all services

sudo service redirect start
sudo service warden start
sudo service update start
