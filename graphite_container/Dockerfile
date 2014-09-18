FROM theport:5000/oel6
RUN rpm -Uvh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
RUN yum -y update
RUN yum -y install python-whisper python-carbon graphite-web python-memcached python-ldap httpd memcached which gcc-c++ git MySQL-python mysql
RUN git clone https://github.com/joyent/node.git && cd node && ./configure && make && make install && cd / && rm -rf node
RUN git clone https://github.com/etsy/statsd.git && cp /statsd/exampleConfig.js /statsd/local.js
RUN yum clean all
RUN rm -f /etc/graphite-web/local_settings.py
RUN rm -f /etc/carbon/storage-schemas.conf
RUN rm -f /statsd/local.js
ADD ./storage-schemas.conf /etc/carbon/storage-schemas.conf
ADD ./storage-aggregation.conf /etc/carbon/storage-aggregation.conf
ADD ./local.js /statsd/local.js
ADD ./startup.sh /opt/startup.sh
ADD ./local_settings.py /etc/graphite-web/local_settings.py
EXPOSE 80
CMD ["/bin/bash","/opt/startup.sh"]
