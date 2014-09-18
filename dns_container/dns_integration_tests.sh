#!/bin/bash
sleep 2
# clean up from prior runs if there was a failure:
curl -i --data 'key=5b384dba-00a9-11e4-8ab1-14109fe011cb&name=shetest001' -X DELETE http://localhost:10000/dns/hosts/v1/ >> /dev/null
#curl -i --data 'key=5b384dba-00a9-11e4-8ab1-14109fe011cb&name=shetestwin001' -X DELETE http://localhost:10000/dns/hosts/v1/win/
curl -i --data 'key=5b384dba-00a9-11e4-8ab1-14109fe011cb&name=shetest002' -X DELETE http://localhost:10000/dns/cnames/v1/ >> /dev/null
sleep 2
#create HOST Record
RESP=$(curl -i --data 'key=5b384dba-00a9-11e4-8ab1-14109fe011cb&name=shetest001&ip=10.158.14.226' -X POST http://localhost:10000/dns/hosts/v1/ | grep "201 CREATED")
echo "Response from host record creation: $RESP - expecting 201 CREATED"
if [ -z "$RESP" ]; then exit 1; fi
sleep 1
#try to create same record again, expect same return
RESP=$(curl -i --data 'key=5b384dba-00a9-11e4-8ab1-14109fe011cb&name=shetest001&ip=10.158.14.226' -X POST http://localhost:10000/dns/hosts/v1/ | grep "201 CREATED")
echo "Response from host record creation: $RESP - expecting 201 CREATED"
if [ -z "$RESP" ]; then exit 2; fi
sleep 1
#create Windows HOST Record
#RESP=$(curl -i --data 'key=5b384dba-00a9-11e4-8ab1-14109fe011cb&name=shetestwin001&ip=10.158.14.226' -X POST http://localhost:10000/dns/hosts/v1/win/ | grep "201 CREATED")
#echo "Response from host record creation: $RESP - expecting 201 CREATED"
#if [ -z "$RESP" ]; then exit 1; fi
#sleep 1
#try to create same record again, expect same return
#RESP=$(curl -i --data 'key=5b384dba-00a9-11e4-8ab1-14109fe011cb&name=shetestwin001&ip=10.158.14.226' -X POST http://localhost:10000/dns/hosts/v1/win/ | grep "201 CREATED")
#echo "Response from host record creation: $RESP - expecting 201 CREATED"
#if [ -z "$RESP" ]; then exit 2; fi
#sleep 1

#get host record
RESP=$(curl "http://dnsapi/dns/hosts/v1/?name=shetest001&key=5b384dba-00a9-11e4-8ab1-14109fe011cb")
if [ "$RESP" == [] ]; then exit 3; fi
sleep 1

#create CNAME Record
RESP=$(curl -i --data 'key=5b384dba-00a9-11e4-8ab1-14109fe011cb&name=shetest002&canon=shetest001' -X POST http://localhost:10000/dns/cnames/v1/ | grep "201 CREATED")
echo "Response from cname record creation: $RESP - expecting 201 CREATED"
if [ -z "$RESP" ]; then exit 4; fi
sleep 1
#try to create same cname record again, expect same return as above
RESP=$(curl -i --data 'key=5b384dba-00a9-11e4-8ab1-14109fe011cb&name=shetest002&canon=shetest001' -X POST http://localhost:10000/dns/cnames/v1/ | grep "201 CREATED")
echo "Response from cname record creation: $RESP - expecting 201 CREATED"
if [ -z "$RESP" ]; then exit 5; fi
sleep 1

#get cname record
RESP=$(curl "http://dnsapi/dns/cnames/v1/?name=shetest002&key=5b384dba-00a9-11e4-8ab1-14109fe011cb")
if [ "$RESP" == [] ]; then exit 6; fi
sleep 1

#delete CNAME Record
RESP=$(curl -i --data 'key=5b384dba-00a9-11e4-8ab1-14109fe011cb&name=shetest002' -X DELETE http://localhost:10000/dns/cnames/v1/ | grep "200 OK")
echo "Response from cname record deletion: $RESP - expecting 200 OK"
if [ -z "$RESP" ]; then exit 7; fi
sleep 1
#delete HOST Record
RESP=$(curl -i --data 'key=5b384dba-00a9-11e4-8ab1-14109fe011cb&name=shetest001' -X DELETE http://localhost:10000/dns/hosts/v1/ | grep "200 OK")
echo "Response from host record deletion: $RESP - expecting 200 OK"
if [ -z "$RESP" ]; then exit 8; fi
#delete HOST Record
#RESP=$(curl -i --data 'key=5b384dba-00a9-11e4-8ab1-14109fe011cb&name=shetestwin001' -X DELETE http://localhost:10000/dns/hosts/v1/win/ | grep "200 OK")
#echo "Response from host record deletion: $RESP - expecting 200 OK"
#if [ -z "$RESP" ]; then exit 8; fi