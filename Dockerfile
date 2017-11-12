#
# Tiny Tiny Rss microservice
#
# Based on Christian Lück <christian@lueck.tv> docker image
# https://github.com/clue/docker-ttrss
#
### Build
# docker build -t ttrss .
#
### Run
# docker run -d --name ttrss -p 8000:80 ttrss
#   or
# docker run -d --name ttrss -e URLPREF=DOMAINNAME -p 8080:8080 ttrss
#   or
# docker run -d --name ttrss -e SELF_URL_PATH=10.11.11.4 -e DB_HOST=10.20.30.4 -e DB_PASS=somepassword -p 8802:80 ttrss
#
### Removing container and image
# docker stop ttrss
# docker rm ttrss
# docker rmi ttrss
#
### Database preparing (MySQL)
# CREATE DATABASE ttrss CHARACTER SET utf8 COLLATE utf8_general_ci; 
# GRANT ALL PRIVILEGES ON ttrss.* TO ttrss@'%' IDENTIFIED BY 'somepassword';
# FLUSH PRIVILEGES;
#
### Additional info
# You can find code here:
#    https://github.com/alive-corpse/docker-ttrss
#

FROM alpine:latest
MAINTAINER Evgeniy Shumilov <evgeniy.shumilov@gmail.com>

# Environment
ENV DB_NAME ttrss
ENV DB_USER ttrss
ENV DB_PASS ttrss
ENV DB_TYPE mysql
ENV DB_PORT 3306
ENV DB_HOST localhost
ENV SELF_URL_PATH http://localhost

ADD entry.sh /usr/local/bin

RUN apk update && apk add nginx php5-fpm php5-json php5-gd php5-mysqli php5-pdo_mysql php5-dom php5-curl php5-mcrypt php5-pcntl php5-posix curl && \
    rm -rf /var/www/* && curl 'https://git.tt-rss.org/git/tt-rss/archive/master.tar.gz' -o /tmp/ttrss.tgz && \
    tar xvzf /tmp/ttrss.tgz -C /tmp && mv /tmp/tt-rss/* /var/www && rm -rf /tmp/* && cp /var/www/config.php-dist /var/www/config.php && \
    chown -R nobody:nobody /var/www/* && chmod +x /usr/local/bin/entry.sh && chmod +x /var/www/update_daemon2.php && \
    mkdir /tmp/client_body && mkdir /tmp/fastcgi_temp && chown nobody:nobody /tmp/*; ln -s /usr/bin/php5 /usr/bin/php; ln -s /usr/bin/php-fpm5 /usr/bin/php-fpm

ADD nginx.conf /etc/nginx
ADD configure-db.php /var/www
ADD mysqltest.php /var/www

WORKDIR /var/www

EXPOSE 80

ENTRYPOINT /usr/local/bin/entry.sh

