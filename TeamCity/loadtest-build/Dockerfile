FROM centos:7
MAINTAINER "Marcin Taracha" <maarcintaracha@gmail.com>

RUN yum install -y epel-release \
    && yum install -y python-pip \
    && yum install -y unzip \
    && yum install -y git \
    && yum install -y telnet \
    && pip install virtualenv


RUN mkdir -p /opt/loadtest \
	&& cd /opt/loadtest \
	&& git clone https://3ecaa9a3fe6e9a8c4ef6a3bd7fe16a5c10bff494:x-oauth@github.com/mtaracha/loadtest-webapp.git . \
	&& pip install --requirement requirements.txt


EXPOSE 6000

COPY ./docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]