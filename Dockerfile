FROM alpine:3.18

LABEL Author="Sivahari"
LABEL Description="Apache JMeter Dockerfile"

ENV JMETER_VERSION "5.6.3"
ENV JMETER_HOME "/opt/apache/apache-jmeter-${JMETER_VERSION}"
ENV JMETER_BIN "${JMETER_HOME}/bin"
ENV PATH "$PATH:$JMETER_BIN"
ENV JMETER_CMD_RUNNER_VERSION "2.3"
ENV JMETER_PLUGIN_MANAGER_VERSION "1.9"
ENV JMETER_PLUGIN_INSTALL_LIST "jpgc-udp,jpgc-graphs-basic"

COPY entrypoint.sh /entrypoint.sh
COPY jmeter-plugin-install.sh /jmeter-plugin-install.sh

# Downloading JMeter
RUN apk --no-cache add curl ca-certificates openjdk17-jre && \
    curl -L https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-${JMETER_VERSION}.tgz --output /tmp/apache-jmeter-${JMETER_VERSION}.tgz && \
    tar -zxvf /tmp/apache-jmeter-${JMETER_VERSION}.tgz && \
    mkdir -p /opt/apache && \
    mv apache-jmeter-${JMETER_VERSION} /opt/apache && \
    rm /tmp/apache-jmeter-${JMETER_VERSION}.tgz && \
    rm -rf /var/cache/apk/* && \
    chmod a+x /entrypoint.sh && \
    chmod a+x /jmeter-plugin-install.sh

# Downloading CMD Runner
RUN /jmeter-plugin-install.sh

RUN curl  -L -o  curl -L -o tag-jmeter-extn-1.1.jar https://www.vinsguru.com/download/87/?tmstv=1727691948
    unzip tag-jmeter-extn-1.1.zip -d  tag-jmeter-extn-1.1
    mv tag-jmeter-extn-1.1/* ${JMETER_HOME}/lib/ext/

ENTRYPOINT [ "/entrypoint.sh" ]
