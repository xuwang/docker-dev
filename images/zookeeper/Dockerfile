FROM ubuntu:12.04

# Zookeeper Version
ENV VERSION 3.4.6
ENV DEBIAN_FRONTEND noninteractive

# Install OpenJDK and Zookeeper.
RUN apt-get update && apt-get install -y openjdk-7-jre-headless wget
RUN wget -q -O - http://mirror.nexcess.net/apache/zookeeper/zookeeper-${VERSION}/zookeeper-${VERSION}.tar.gz  \
  | tar -xvzf - -C /opt && \
  ln -s /opt/zookeeper-${VERSION} /opt/zookeeper

ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64

ADD zoo.cfg /opt/zookeeper/conf/zoo.cfg
ADD log4j.properties /opt/zookeeper/conf/log4j.properties

VOLUME [ "/data" ]
VOLUME [ "/logs" ]

WORKDIR /opt/zookeeper

EXPOSE 2181 2888 3888

ENTRYPOINT ["/opt/zookeeper/bin/zkServer.sh"]
CMD ["start-foreground"]