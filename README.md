# kafka manager Dockerfile
[kafka manager](https://github.com/yahoo/kafka-manager) is a tool from Yahoo Inc. for managing [Apache Kafka](http://kafka.apache.org).
## Base Docker Images ##
* [dockerfile/java:oracle-java8](https://registry.hub.docker.com/u/dockerfile/java)
* [hseeberger/scala-sbt](https://registry.hub.docker.com/u/hseeberger/scala-sbt/)

## Howto
```
docker run -it --rm  -p 9000:9000 -e ZK_HOSTS="your-zk.domain:2181" -e APPLICATION_SECRET=letmein sheepkiller/kafka-manager
```
(if you don't define ZK_HOSTS, default value has been set to "localhost:2181")

you can also override conf with local configuration files:
```
docker run [...] -v /path/to/confdir:/kafka-manager-1.2.0/conf [...]
```

## Specify a revision
If you want to upgrade/downgrade this Dockerfile, edit it and set `KV_REVISION` to desired one (from rev `c9a9093b72fd296d1634854fe8150dcc4b861882`)
