FROM centos:7
MAINTAINER "Marcin Taracha" <maarcintaracha@gmail.com>

RUN yum install -y epel-release \
    && yum install -y python-pip \
    && yum install -y unzip \
    && yum install -y git \
    && yum install -y telnet \
    && yum install -y jq \
    && pip install virtualenv

RUN mkdir -p /opt/loadtest

COPY vault_auth_get.sh /opt/loadtest/

RUN cd /opt/loadtest \
	&& github_token=$(/opt/loadtest/vault_auth_get.sh -s 7.7.7.73:8200 -p secret/github/access_token -r 7f538aca-bcdc-f6e1-fec8-2b6d8689a480 -S d3d156fc-2a0e-07dd-0aea-3e5b20705abd) \
	&& git clone https://$github_token:x-oauth@github.com/mtaracha/loadtest-webapp.git \
	&& cd loadtest-webapp \
	&& pip install --requirement requirements.txt

EXPOSE 6000

COPY ./docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]