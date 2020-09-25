#!/bin/bash

OPENJDK_VERSION=jdk8u265-b01
OPENJDK_URL=https://github.com/AdoptOpenJDK/openjdk8-binaries/releases/download/${OPENJDK_VERSION}/OpenJDK8U-jre_x64_linux_hotspot_8u265b01.tar.gz
JAVA_HOME=/etc/alternatives/${OPENJDK_VERSION}-jre

curl --progress-bar -L ${OPENJDK_URL} | tar xz -C /etc/alternatives
ln -s ${JAVA_HOME}/bin/java /usr/local/bin
java -version
