# logstash-forwarder
#
# A tool to collect logs locally in preparation for processing elsewhere
#
# VERSION               0.3.1

FROM      debian:sid
MAINTAINER Deni Bertovic "deni@kset.org"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update

# install deps
RUN apt-get install -y wget git ruby ruby-dev rubygems irb ri rdoc build-essential libopenssl-ruby1.9.1 libssl-dev zlib1g-dev

# Do not install go via debian packages, which will install go 1.3 
# Get GO 1.2.2 binary (as 1.3 is the only available in sid ... and 1.3 isn't OK with SSL Certs cf. https://github.com/elasticsearch/logstash-forwarder/pull/217)
RUN wget -q "http://golang.org/dl/go1.2.2.linux-amd64.tar.gz" -O /tmp/go.tar.gz && \
	cd /tmp && tar zxvf go.tar.gz && mv /tmp/go /opt/go && \
	rm /tmp/go.tar.gz

# clone logstash-forwarder
RUN git clone git://github.com/elasticsearch/logstash-forwarder.git /tmp/logstash-forwarder
RUN cd /tmp/logstash-forwarder && git checkout v0.3.1 && export GOROOT=/opt/go && /opt/go/bin/go build

# Install fpm
RUN gem install fpm

# Build deb
RUN cd /tmp/logstash-forwarder && export GOROOT=/opt/go && export PATH=$PATH:$GOROOT/bin && make deb
RUN dpkg -i /tmp/logstash-forwarder/*.deb

# Cleanup
RUN rm -rf /tmp/*

# Add FIFO
RUN mkdir /tmp/feeds/ && mkfifo /tmp/feeds/fifofeed

ADD run.sh /usr/local/bin/run.sh
RUN chmod 755 /usr/local/bin/run.sh

RUN mkdir /opt/certs/
ADD certs/logstash-forwarder.crt /opt/certs/logstash-forwarder.crt
ADD certs/logstash-forwarder.key /opt/certs/logstash-forwarder.key

CMD /usr/local/bin/run.sh
