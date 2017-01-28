FROM centos:7
MAINTAINER "Marcin Taracha" <maarcintaracha@gmail.com>

RUN yum install -y epel-release \
    && yum install -y python-pip \
    && yum install -y unzip \
    && yum install -y git \
    && yum install -y telnet \
    && yum install -y jq \
    && pip install virtualenv

ARG vault_endpoint=7.7.7.73:8200
ENV role_id="7f538aca-bcdc-f6e1-fec8-2b6d8689a480"
ENV secret_id="d3d156fc-2a0e-07dd-0aea-3e5b20705abd"

#RUN mkdir -p /opt/heavy-api

COPY vault_auth_get.sh /opt/

RUN cd /opt/ \
	&& github_token=$(/opt/vault_auth_get.sh -s $vault_endpoint -p secret/github/access_token -r ${role_id} -S ${secret_id}) \
	&& git clone https://$github_token:x-oauth@github.com/mtaracha/heavy-api.git 

RUN	cd /opt/heavy-api \
	&& pip install --requirement requirements.txt 

EXPOSE 5000

COPY ./docker-entrypoint.sh /
ENTRYPOINT ["python", "/opt/heavy-api/heavy-api.py"]
#ENTRYPOINT ["bash", "docker-entrypoint.sh"]