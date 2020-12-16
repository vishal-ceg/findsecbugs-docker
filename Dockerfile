FROM java:8-jdk-alpine
ENV SPOTBUGS_VERSION=3.1.12
ENV FINDSEC_VERSION=1.10.1

WORKDIR /usr/workdir
RUN apk add --update \
    curl \
    && rm -rf /var/cache/apk/*

    RUN curl -sL \
     https://repo.maven.apache.org/maven2/com/github/spotbugs/spotbugs/${SPOTBUGS_VERSION}/spotbugs-${SPOTBUGS_VERSION}.tgz | \
    tar -xz  && \
    mv spotbugs-* /usr/bin/findbugs && \
    mkdir /temp

 RUN curl -sL \
     https://github.com/find-sec-bugs/find-sec-bugs/releases/download/version-${FINDSEC_VERSION}/findsecbugs-cli-${FINDSEC_VERSION}.zip -o /temp/findsecbug.zip && \
     unzip /temp/findsecbug.zip -d /temp && \
     mv /temp/lib/findsecbugs-plugin-${FINDSEC_VERSION}.jar /usr/bin/findbugs/lib/findsecbugs-plugin.jar && \
     mv /temp/include.xml /usr/bin/findbugs/lib/include.xml && \
     rm -rf /temp
  
   
ADD target/findsecbugs-docker-1.0-SNAPSHOT-jar-with-dependencies.jar /usr/bin/findbugs/lib/app.jar 

WORKDIR /workdir

ENTRYPOINT ["java","-jar","/usr/bin/findbugs/lib/app.jar"]
CMD ["-h"]
    