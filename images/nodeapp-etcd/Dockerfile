FROM ubuntu:14.04

ENV DEBIAN_FRONTEND noninteractive

# install sshd and other tool sets
RUN apt-get update
RUN apt-get install -y curl wget nodejs supervisor git-core golang && \
	apt-get clean
	
RUN git clone https://github.com/coreos/etcdctl.git; \
		cd etcdctl;./build; \
		cp bin/etcdctl /usr/bin/etcdctl; \
		cd ..;\
		rm -r etcdctl
	
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

ADD appreg.sh /appreg.sh
ADD server.js /server.js
RUN chmod a+x /appreg.sh

EXPOSE 8000

CMD ["/usr/bin/supervisord"]