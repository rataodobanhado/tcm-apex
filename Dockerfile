FROM ubuntu:14.04.1

MAINTAINER Francisco Neto <francisco.neto@tcm.pa.gov.br> based on Andrzej Raczkowski's <araczkowski@gmail.com> docker image

# passar como argumento
# --build-arg ENVIRONMENT=LOCAL
# para não baixar da web os arquivos
ARG ENVIRONMENT
ENV ENVIRONMENT ${ENVIRONMENT:-WEB}


ENV PASSWORD secret

# get rid of the message: "debconf: unable to initialize frontend: Dialog"
ENV DEBIAN_FRONTEND noninteractive
ENV ORACLE_HOME /u01/app/oracle/product/11.2.0/xe
ENV PATH $ORACLE_HOME/bin:$PATH
ENV ORACLE_SID=XE

EXPOSE 1521 8080

# all installation files
COPY scripts /scripts

# ! to speed up the build process 
if [ "$ENVIRONMENT" == "LOCAL" ]
then
    COPY files /files
fi
S
# start the installation
RUN /scripts/install_main.sh


# ENTRYPOINT
ADD entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
