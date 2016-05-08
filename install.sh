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
      sudo apt install git-core;;
    nix)
      sudo nix-env -i git;;
  esac
  echo "Installation of git done.";
fi;

if ! which node > /dev/null;
  then echo "Node is not installed. Installation of Node in progress.";
  case $PM in
    ubuntu)
      sudo apt install nodejs;;
    nix)
      sudo nix-env -i nodejs;;
  esac
  echo "Installation of Node done.";
fi;

if ! which openssl > /dev/null;
  then echo "openssl is not installed. Installation of openssl in progress.";
  case $PM in
    ubuntu)
      sudo apt install openssl;;
    nix)
      sudo nix-env -i openssl;;
  esac
  echo "Installation of openssl done.";
fi;

# clone repositories

git clone https://github.com/garden/services /home/dom/services
git clone https://github.com/garden/tree /home/dom/tree

pushd /home/dom/tree

  # populate tree

  git clone https://github.com/garden/plugs.git
  make load
  npm install

  # generate HTTPS credentials

  cd /home/dom/tree
  openssl genrsa -aes256 -out https.key 1024
  openssl req -new -nodes -key https.key -out https.csr
  openssl x509 -req -days 365 -in https.csr -signkey https.key -out https.crt
  cp https.key{,.orig}
  openssl rsa -in https.key.orig -out https.key

popd

# install service scripts

sudo cp /home/dom/services/tree.service /etc/systemd/system/
sudo cp /home/dom/services/redirect.service /etc/systemd/system/
sudo cp /home/dom/services/update.service /etc/systemd/system/

systemctl daemon-reload

# start all services

systemctl start tree.service
systemctl start redirect.service
systemctl start update.service
