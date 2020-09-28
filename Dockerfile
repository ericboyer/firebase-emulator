FROM registry.access.redhat.com/ubi8/ubi-minimal:latest

ARG PROJECT
ARG TOKEN

# install packages
RUN microdnf install tar gzip shadow-utils sudo && \
  useradd -ms /bin/bash firebase && \
  usermod -aG root firebase

WORKDIR /home/firebase

ADD config/* ./
ADD install-openjdk8-jre.sh .

# install JRE and firebase toolset
RUN chmod u+x install-openjdk8-jre.sh && \
  ./install-openjdk8-jre.sh && \
  curl -sL firebase.tools | bash

# expose firestore and UI ports
EXPOSE 8080 8088

# switch user ...
USER firebase

# and start emulators
CMD firebase -P $PROJECT emulators:start --token $TOKEN --debug
