FROM ubuntu:14.04

ENV DEBIAN_FRONTEND noninteractive

# install sshd and other tool sets
RUN apt-get update
RUN apt-get install -y curl wget nodejs
RUN apt-get install -y supervisor
	
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

ADD dockreg /usr/bin/dockreg
ADD server.js /server.js
ADD run.sh /run.sh
RUN chmod a+x /usr/bin/dockreg
RUN chmod a+x /run.sh

EXPOSE 8000

CMD ["/run.sh"]