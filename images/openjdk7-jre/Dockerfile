FROM ubuntu:14.04

ENV DEBIAN_FRONTEND noninteractive

# Install OpenJDK and Zookeeper.
RUN apt-get update && apt-get install -y openjdk-7-jre-headless wget

ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64