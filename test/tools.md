Apache Kafka C/C++ client library [librdkafka](https://github.com/edenhill/librdkafka)
=====================================================================

##Build

```
sudo apt-get -y install git curl build-essential wget libgcrypt11-dev zlib1g-dev
git clone https://github.com/edenhill/librdkafka.git
cd librdkafka/
./configure
make
sudo make install
```


Cat for Kafka: [kafkacat](https://github.com/edenhill/kafkacat)
===================================================

## Quick Build

```
git clone https://github.com/edenhill/kafkacat.git
cd kafkacat/
./bootstrap.sh
sudo make install
```

## Build
```
git clone https://github.com/edenhill/kafkacat.git
cd kafkacat/
./configure --enable-static
make
sudo make install
```

## Test

### Prepare
```
sudo apt-get install fortune-mod
touch logs
```
### Start Producer
```
docker run -it --rm --link kafka:kafka localhost:5000/sandbox bash -l
cd /tmp
touch logs
tail -f logs | kafkacat -P -b kafka -t test -p 0 -z snappy &
while true
do 
 echo `date`:$((RANDOM%=255))"."$((RANDOM%=255))"."$((RANDOM%=255))"."$((RANDOM%=255)):`/usr/games/fortune` >> logs
 sleep 3
done
```
### Start Consumer
```
docker run -it --rm --link kafka:kafka localhost:5000/sandbox bash -l
kafkacat -C -b kafka -t test -p 0
```

