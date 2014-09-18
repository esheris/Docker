sed -i s/__replace__/$RANDOM/g /etc/my.cnf
/usr/bin/mysqld_safe &
sleep 5s
echo "GRANT ALL ON *.* TO admin@'%' IDENTIFIED BY 'changeme' WITH GRANT OPTION; FLUSH PRIVILEGES" | mysql
echo "GRANT ALL ON *.* TO replication@'%' IDENTIFIED BY 'replicateme'; FLUSH PRIVILEGES" | mysql
killall mysqld
sleep 5s
/usr/bin/mysqld_safe
