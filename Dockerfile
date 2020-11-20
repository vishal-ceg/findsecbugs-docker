FROM java:8-jdk-alpine
ENV FINDBUGS_VERSION=3.0.1

WORKDIR /usr/workdir
RUN apk add --update \
    curl \
    && rm -rf /var/cache/apk/*

RUN curl -sL \
      https://sourceforge.net/projects/findbugs/files/findbugs/${FINDBUGS_VERSION}/findbugs-${FINDBUGS_VERSION}.tar.gz/download | \
    tar -xz  && \
    mv findbugs-* /usr/bin/findbugs

ADD findsecbugs-plugin-1.7.1.jar /usr/bin/findbugs/lib/findsecbugs-plugin.jar 
WORKDIR /workdir

ENTRYPOINT ["java","-jar","/usr/bin/findbugs/lib/findbugs.jar","-pluginList","/usr/bin/findbugs/lib/findsecbugs-plugin.jar"]
CMD ["-h"]

