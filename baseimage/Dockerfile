# Copyright (c) Damien Goetschi
# Image with all prerequisites to build WindNinja to speed up WindNinja image build
# and avoid redownloading all dependencies each time
#
FROM ubuntu:20.04

USER root
ADD build_deps_ubuntu_2004.sh /opt/src/build_deps_ubuntu_2004.sh
SHELL [ "/usr/bin/bash", "-c" ]
ENV DEBIAN_FRONTEND noninteractive
RUN dpkg-reconfigure debconf --frontend=noninteractive
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y wget gnupg2 cmake git apt-transport-https ca-certificates \
                       software-properties-common sudo build-essential \
                       pkg-config g++ libboost-program-options-dev \
                       libboost-date-time-dev libboost-test-dev
RUN cd /opt/src && \
    DEBIAN_FRONTEND=noninteractive ./build_deps_ubuntu_2004.sh && \
    rm -rf /var/lib/apt/lists
