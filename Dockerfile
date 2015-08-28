FROM ubuntu:14.04
MAINTAINER taomareee@gmail.com

ENV DEBIAN_FRONTEND=noninteractive \
	TZ='Asia/Shanghai' \
	APP_USER=redis \
    APP_DATA_DIR=/var/lib/redis \
    APP_LOG_DIR=/var/log/redis

RUN echo "APT::Install-Recommends 0;" >> /etc/apt/apt.conf.d/01norecommends \
 && echo "APT::Install-Suggests 0;" >> /etc/apt/apt.conf.d/01norecommends \ 
 && sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list \
 && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 136221EE520DDFAF0A905689B9316A7BC7917B12 \
 && echo "deb http://ppa.launchpad.net/chris-lea/redis-server/ubuntu trusty main"  > /etc/apt/sources.list.d/redis.list \
 && apt-get update \
 && apt-get install -y redis-server monit \
 && sed 's/^daemonize yes/daemonize no/' -i /etc/redis/redis.conf \
 && sed 's/^bind 127.0.0.1/bind 0.0.0.0/' -i /etc/redis/redis.conf \
 && sed 's/^# unixsocket /unixsocket /' -i /etc/redis/redis.conf \
 && sed 's/^# unixsocketperm 755/unixsocketperm 777/' -i /etc/redis/redis.conf \
 && sed '/^logfile/d' -i /etc/redis/redis.conf \
 && rm -rf /var/lib/apt/lists/* \
 && mkdir -p /var/run/redis


EXPOSE 6379/tcp
VOLUME ["${APP_DATA_DIR}"]

CMD /usr/bin/redis-server /etc/redis/redis.conf 




