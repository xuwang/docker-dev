FROM ubuntu:14.04

ENV DEBIAN_FRONTEND noninteractive

# install sshd and other tool sets
RUN apt-get update && \
	apt-get install -y openssh-server git curl wget build-essential libgcrypt11-dev zlib1g-dev mysql-client-5.6 fortune-mod && \
	mkdir /var/run/sshd && \
	echo 'root:sandbox' | chpasswd

# install kafkacat
RUN git clone https://github.com/edenhill/kafkacat.git && \
	cd kafkacat/ && \
	./bootstrap.sh && \
	make install
	
#fix the 14.04 ssh login problem	RUN mkdir -p /var/run/sshd
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
RUN sed -ri 's/#UsePAM no/UsePAM no/g' /etc/ssh/sshd_config
RUN sed -ri 's/PermitRootLogin without-password/PermitRootLogin yes/g' /etc/ssh/sshd_config

EXPOSE 22
CMD    ["/usr/sbin/sshd", "-D"]