FROM theport:5000/oel6
RUN yum -y update
RUN yum -y install mysql-server
RUN yum clean all
RUN mysql_install_db
RUN rm -f /etc/my.cnf
ADD ./my.cnf /etc/my.cnf
ADD ./startup.sh /opt/startup.sh
EXPOSE 3306
CMD ["/bin/bash","/opt/startup.sh"]
