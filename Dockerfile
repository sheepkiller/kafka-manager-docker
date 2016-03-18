FROM centos:7

MAINTAINER Clement Laforet <sheepkiller@cultdeadsheep.org>

RUN yum update -y && \
    yum install -y git wget unzip which && \
    yum clean all

ENV JAVA_MAJOR=8 \
    JAVA_UPDATE=73 \
    JAVA_BUILD=02 

RUN wget --no-cookies --no-check-certificate \
    --header "Cookie: oraclelicense=accept-securebackup-cookie" \
    "http://download.oracle.com/otn-pub/java/jdk/${JAVA_MAJOR}u${JAVA_UPDATE}-b${JAVA_BUILD}/jdk-${JAVA_MAJOR}u${JAVA_UPDATE}-linux-x64.rpm" -O /tmp/jdk-${JAVA_MAJOR}u${JAVA_UPDATE}-linux-x64.rpm && \
     yum localinstall -y /tmp/jdk-${JAVA_MAJOR}u${JAVA_UPDATE}-linux-x64.rpm && \
     rm -f /tmp/jdk-${JAVA_MAJOR}u${JAVA_UPDATE}-linux-x64.rpm

ENV JAVA_HOME=/usr/java/jdk1.8.0_${JAVA_UPDATE} \
    ZK_HOSTS=localhost:2181 \
    KM_VERSION=1.3.0.4 \
    KM_REVISION=master \
    KM_CONFIGFILE="conf/application.conf"

RUN mkdir -p /tmp && \
    cd /tmp && \
    git clone https://github.com/yahoo/kafka-manager && \
    cd /tmp/kafka-manager && \
    git checkout ${KM_REVISION} && \
    echo 'scalacOptions ++= Seq("-Xmax-classfile-name", "200")' >> build.sbt && \
    ./sbt clean dist && \
    unzip  -d / ./target/universal/kafka-manager-${KM_VERSION}.zip && \
    rm -fr /tmp/* /root/.sbt /root/.ivy2 && \
    printf '#!/bin/sh\nexec ./bin/kafka-manager -Dconfig.file=${KM_CONFIGFILE} "${KM_ARGS}" "${@}"\n' > /kafka-manager-${KM_VERSION}/km.sh && \
    chmod +x /kafka-manager-${KM_VERSION}/km.sh

WORKDIR /kafka-manager-${KM_VERSION}

EXPOSE 9000
ENTRYPOINT ["./km.sh"]
