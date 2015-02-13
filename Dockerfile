FROM hseeberger/scala-sbt

MAINTAINER Clement Laforet <sheepkiller@cultdeadsheep.org>

ENV ZK_HOST localhost:2181
ENV KM_REVISION 15c902dd2aad2696610b3a34f3f0905d3919903d

RUN cd / && \
    git clone https://github.com/yahoo/kafka-manager && \
    cd /kafka-manager && \
    git checkout ${KM_REVISION} && \
    sbt clean dist && \
    unzip  -d / ./target/universal/kafka-manager-1.0-SNAPSHOT.zip

WORKDIR /kafka-manager-1.0-SNAPSHOT

EXPOSE 9000
ENTRYPOINT ["./bin/kafka-manager"]
