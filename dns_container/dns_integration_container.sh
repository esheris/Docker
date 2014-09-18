#!/bin/bash

docker kill dnsapi_test
docker rm dnsapi_test
docker build -t dnsapi_test /apps/gitrepos/DNSAPI
docker run -e DJANGO_SETTINGS_MODULE=DNSRestApi.settings-test -d -p 10000:80 --name=dnsapi_test dnsapi_test
