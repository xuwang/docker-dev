FROM ubuntu:12.04

ENV DEBIAN_FRONTEND noninteractive
RUN \  
  apt-get update && \
  apt-get install -y python-software-properties software-properties-common wget curl git && \
  add-apt-repository ppa:webupd8team/java && \
  apt-get update && \
  echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections && \
  apt-get install -y -q oracle-java7-installer