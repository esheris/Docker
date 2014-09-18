FROM theport:5000/oel6

MAINTAINER T-Mobile

RUN yum update -y
#RUN yum install -y git perl perl-base netbase perl-modules liberror-perl gcc
RUN yum install -y python python-devel python-setuptools gcc
ADD ./docker/nginx.repo /etc/yum.repos.d/nginx.repo
RUN yum install -y nginx
RUN easy_install pip

# setup all the configfiles
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
RUN rm /etc/nginx/conf.d/default.conf
RUN ln -s /home/docker/code/docker/nginx-app.conf /etc/nginx/conf.d/

# uWSGI!
RUN pip install uwsgi

# add and install RPMs
ADD ./docker/rpms /home/docker/code/docker/rpms
RUN yum install -y /home/docker/code/docker/rpms/*

# RUN pip install
RUN pip install Django==1.6.5
RUN pip install djangorestframework==2.3.14
RUN pip install simplejson==3.5.3
RUN pip install wsgiref==0.1.2

# install our code
ADD . /home/docker/code/


RUN export DJANGO_SETTINGS_MODULE=DNSRestApi.settings-test; python /home/docker/code/manage.py collectstatic --noinput

EXPOSE 80
CMD ["/sbin/runsvdir", "/home/docker/code/docker/runit"]
