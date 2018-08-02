FROM daocloud.io/shaoling/workspace-env-base

ENV DEBIAN_FRONTEND noninteractive

# install nginx
RUN apt-get update && apt-get install -y nginx && \
    rm -rf /var/lib/apt/list/* && \
    echo "\ndaemon off;" >> /etc/nginx/nginx.conf

# change timezone
RUN apt-get update && apt-get install -y tzdata && \ 
    echo "Asia/Shanghai" > /etc/timezone && \
    dpkg-reconfigure -f noninteractive tzdata

ADD run.sh /run.sh
RUN chmod 755 /*.sh

VOLUME ["/etc/nginx/sites-enabled", "/etc/nginx/certs", \
        "/etc/nginx/conf.d", "/var/log/nginx"]

WORKDIR /etc/nginx

EXPOSE 80
EXPOSE 443

CMD ["/run.sh"]
