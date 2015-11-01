FROM hseeberger/scala-sbt

MAINTAINER Clement Laforet <sheepkiller@cultdeadsheep.org>

ENV ZK_HOSTS=localhost:2181 \
     KM_VERSION=1.2.9.6 \
     KM_REVISION=2f7710ff715b9ad65c60d37b287b71bad57a478b

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
