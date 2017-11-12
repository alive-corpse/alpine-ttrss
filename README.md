# Docker container by Evgeniy Shumilov (evgeniy.shumilov@gmail.com) for Tiny Tiny RSS by Andrew Dolgov (https://tt-rss.org) based on https://github.com/clue/docker-ttrss

## About Tiny Tiny RSS

> *From [the official readme](http://tt-rss.org/redmine/projects/tt-rss/wiki):*

Tiny Tiny RSS is an open source web-based news feed (RSS/Atom) reader and aggregator,
designed to allow you to read news from any location,
while feeling as close to a real desktop application as possible.

![](http://tt-rss.org/images/1.9/1.jpg)

## Main changes

I made it with default settings for using with mysql and changed debian image to latest alpine. Also I wrote some initialisation scripts, made some fixes in nginx configs to make in working in alpine and resolved all needed dependencies. At the moment docker image takes 57.19 MB of disk size. It's much less than with debian image.

## Installation and parameters

#### Building image

docker build -t ttrss .

#### Default parameters

```bash
ENV DB_NAME ttrss
ENV DB_USER ttrss
ENV DB_PASS ttrss
ENV DB_TYPE mysql
ENV DB_PORT 3306
ENV DB_HOST localhost
ENV SELF_URL_PATH http://localhost
```

You also can change any of this parameters with '-e' directive for run command.

#### Run examples

```bash
docker run -d --name ttrss -p 8000:80 ttrss
# or with domain prefix
docker run -d --name ttrss -e URLPREF=DOMAINNAME -p 8080:8080 ttrss
# or with domain prefix and mysql url/password and other port to mapping
docker run -d --name ttrss -e SELF_URL_PATH=10.11.11.4 -e DB_HOST=10.20.30.4 -e DB_PASS=somepassword -p 8802:80 ttrss
```

#### Removing

```bash
docker stop ttrss
docker rm ttrss
docker rmi ttrss
```

## Notice

This dockerfile and scripts are provided for free and without any garanties. But you can feel free to send me any feedback to evgeniy.shumilov@gmail.com

