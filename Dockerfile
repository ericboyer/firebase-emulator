FROM registry.access.redhat.com/ubi8/ubi-minimal:latest

ARG PROJECT
ARG TOKEN

WORKDIR /firebase

ADD config/* ./
ADD install-openjdk8-jre.sh .

# install tools
RUN microdnf install tar gzip && \
  chmod u+x install-openjdk8-jre.sh && \
  ./install-openjdk8-jre.sh && \
  curl -sL firebase.tools | sed s/sudo//g - | bash

EXPOSE 8080 8088

CMD firebase -P $PROJECT emulators:start --token $TOKEN
