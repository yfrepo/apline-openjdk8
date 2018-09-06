# Alpine Linux with openjdk8
FROM alpine:3.7

#------------------------
# initial steps
RUN apk update \
    && apk add --no-cache curl

#------------------------
# jdk steps
RUN apk add --no-cache openjdk8
RUN { \
        echo '#!/bin/ash'; \
        echo 'set -e'; \
        echo; \
        echo 'export JAVA_HOME=$(dirname $(dirname $(dirname $(readlink -f $(which java)))))'; \
	echo 'export PATH=$PATH:$JAVA_HOME/bin'; \
    } > /etc/profile.d/java.sh \
    && chmod +x /etc/profile.d/java.sh
     
ENV JAVA_HOME /usr/lib/jvm/default-jvm
ENV PATH $PATH:$JAVA_HOME/bin

#-----------------------
# remove redundant resources
RUN apk del curl
RUN rm -rf /var/cache/apk/*
