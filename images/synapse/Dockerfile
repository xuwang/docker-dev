FROM ubuntu:14.04

ENV DEBIAN_FRONTEND noninteractive

# install sshd and other tool sets
RUN apt-get update
RUN apt-get install -y build-essential ruby ruby-dev haproxy
RUN gem install synapse
RUN sed -ri 's/ENABLED=0/ENABLED=1/' /etc/default/haproxy

ADD synapse.json.conf /etc/synapse.json.conf
ADD run.sh	/run.sh
RUN chmod a+x /run.sh

EXPOSE 8080

CMD    ["/run.sh"]