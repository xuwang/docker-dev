FROM ubuntu:14.04

# Redis Version
ENV VERSION stable
ENV DEBIAN_FRONTEND noninteractive

# Install Redis.
RUN \
  apt-get update && \
  apt-get install -y git curl build-essential make gcc wget && \
  cd /tmp && \
  wget http://download.redis.io/releases/redis-$VERSION.tar.gz && \
  tar xvzf redis-$VERSION.tar.gz && \
  cd redis-$VERSION && \
  make && \
  make install && \
  cp -f src/redis-sentinel /usr/local/bin && \
  mkdir -p /etc/redis && \
  cp -f *.conf /etc/redis && \
  rm -rf /tmp/redis-stable*

# Use custmized redis.conf
ADD redis.conf /etc/redis/redis.conf

# Define mountable directories.
VOLUME [ "/logs" ]
VOLUME [ "/data" ]

# Define working directory.
WORKDIR /data

ENTRYPOINT ["redis-server"]

# Define default command.
CMD ["/etc/redis/redis.conf"]

# Expose ports.
EXPOSE 6379
