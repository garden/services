#!/bin/bash

cd /home/dom/tree
openssl genrsa -aes256 -out https.key 1024
openssl req -new -nodes -key https.key -out https.csr
openssl x509 -req -days 365 -in https.csr -signkey https.key -out https.crt
cp https.key{,.orig}
openssl rsa -in https.key.orig -out https.key
