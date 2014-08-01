FROM openjdk7-jre

# Zookeeper Version
ENV VERSION 3.4.6
ENV DEBIAN_FRONTEND noninteractive

# Install OpenJDK and Zookeeper.
RUN mkdir /data /logs /zookeeper
RUN wget -q -O - http://mirror.nexcess.net/apache/zookeeper/zookeeper-${VERSION}/zookeeper-${VERSION}.tar.gz  \
  | tar -xvzf - -C /zookeeper --strip-components=1

ADD zoo.cfg /zookeeper/conf/zoo.cfg
ADD log4j.properties /zookeeper/conf/log4j.properties

VOLUME [ "/data", "/logs" ]

EXPOSE 2181 2888 3888

ENTRYPOINT ["/zookeeper/bin/zkServer.sh"]
CMD ["start-foreground"]