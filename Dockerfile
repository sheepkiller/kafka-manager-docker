FROM hseeberger/scala-sbt

MAINTAINER Clement Laforet <sheepkiller@cultdeadsheep.org>

ENV ZK_HOSTS=localhost:2181 \
     KM_VERSION=1.2.9.8 \
     KM_REVISION=0f5b85ef26ade06314b96d5c933e1122d36b0cb8

RUN mkdir -p /tmp && \
    cd /tmp && \
    git clone https://github.com/yahoo/kafka-manager && \
    cd /tmp/kafka-manager && \
    git checkout ${KM_REVISION} && \
    sbt clean dist && \
    unzip  -d / ./target/universal/kafka-manager-${KM_VERSION}.zip && \
    rm -fr /tmp/*

WORKDIR /kafka-manager-${KM_VERSION}

EXPOSE 9000
ENTRYPOINT ["./bin/kafka-manager","-Dconfig.file=conf/application.conf"]
