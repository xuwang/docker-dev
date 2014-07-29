FROM xuwang/openjdk7-jre

# Kafka Version
ENV VERSION 0.8.1.1
ENV DEBIAN_FRONTEND noninteractive

RUN mkdir /data /logs /kafka
RUN wget -q -O - http://apache.mirrors.pair.com/kafka/${VERSION}/kafka_2.9.2-${VERSION}.tgz  \
  | tar -xvzf - -C /kafka --strip-components=1

ADD http://repo1.maven.org/maven2/org/slf4j/slf4j-log4j12/1.7.6/slf4j-log4j12-1.7.6.jar /kafka/lib/slf4j-log4j12.jar
ADD server.properties /kafka/config/server.properties.tmpl
ADD log4j.properties /kafka/config/log4j.properties
ADD kafka-start.sh /kafka-start.sh

VOLUME [ "/data", "/logs" ]

# primary, jmx
EXPOSE 9092 7203

CMD ["/kafka-start.sh"]