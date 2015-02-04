FROM hseeberger/scala-sbt

MAINTAINER Clement Laforet <sheepkiller@cultdeadsheep.org>

RUN cd / && \
    git clone https://github.com/yahoo/kafka-manager && \
    cd /kafka-manager && \
    sed -i'' 's/kafka-manager-zookeeper:2181/localhost:2181/' conf/application.conf && \
    printf 'kafka-manager.zkhosts=${?ZK_HOSTS}\n' >> conf/application.conf && \
    sbt clean dist && \
    unzip  -d / ./target/universal/kafka-manager-1.0-SNAPSHOT.zip

WORKDIR /kafka-manager-1.0-SNAPSHOT

EXPOSE 9000
ENTRYPOINT ["./bin/kafka-manager"]
