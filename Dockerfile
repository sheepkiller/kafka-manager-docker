FROM hseeberger/scala-sbt

MAINTAINER Clement Laforet <sheepkiller@cultdeadsheep.org>

ENV ZK_HOSTS=localhost:2181 \
     KM_REVISION=cb80161dc6b828ad67d2b78ad81e83fd47e50454 \
     KM_VERSION=1.2.2

RUN cd / && \
    git clone https://github.com/yahoo/kafka-manager && \
    cd /kafka-manager && \
    git checkout ${KM_REVISION} && \
    sbt clean dist && \
    unzip  -d / ./target/universal/kafka-manager-${KM_VERSION}.zip

WORKDIR /kafka-manager-${KM_VERSION}

EXPOSE 9000
ENTRYPOINT ["./bin/kafka-manager","-Dconfig.file=conf/application.conf"]
