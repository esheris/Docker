#! /bin/bash

echo `hostname`

cd /apps/gitrepos/DNSAPI
git pull
docker build -t dnsapi .
docker kill dnsapi
docker rm dnsapi
docker run -e DJANGO_SETTINGS_MODULE=DNSRestApi.settings -d -p 8081:80 --name=dnsapi dnsapi
docker kill dnsapi_test
docker rm dnsapi_test
