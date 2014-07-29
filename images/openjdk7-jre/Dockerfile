FROM ubuntu

ENV DEBIAN_FRONTEND noninteractive

# Install OpenJDK and Zookeeper.
RUN apt-get update && apt-get install -y openjdk-7-jre-headless wget

ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64