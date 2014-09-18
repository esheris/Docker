if mysql -uadmin -pchangeme -h db -P 3306 graphite >/dev/null 2>&1 </dev/null; then echo "db exists and perms"; else mysql -uadmin -pchangeme -h db -P 3306 -e "CREATE DATABASE IF NOT EXISTS graphite"; mysql -uadmin -pchangeme -h db -P 3306 -e "GRANT ALL PRIVILEGES ON graphite.* TO 'graphite'@'%' IDENTIFIED BY 'graphite'; FLUSH PRIVILEGES;"; python /usr/lib/python2.6/site-packages/graphite/manage.py syncdb --noinput; fi
service carbon-cache restart
service memcached restart
service httpd restart
node /statsd/stats.js /statsd/local.js
