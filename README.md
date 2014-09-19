graphite_docker
===============
```
docker run -d --name db -p 3306:3306 theport:5000/mysql
sleep 10s # need to wait for db container to run it's startup script
docker run -d -p 80:80 -p 8125:8125 --name web --link db:db theport:5000/graphite
```

