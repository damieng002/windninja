# Copyright (c) Kyle Shannon
# Distributed under the terms of the Modified BSD License.
#
# Note, to use this X11 application from within a container, you need to
# allow X11 connections from other hosts as well as extra 
# command line options on the docker (or podman) run line. To access data
# from outside the narrow confines of the WindNinja container, you'll also
# need to specify a volume mount. By default, this container uses "/data" as 
# a working directory. For instance, as an unpriviledged user 
# using podman: 
# 
#     mkdir $HOME/MyWindNinjaRuns
#     xhost +
#     podman run -ti --rm \
#                -e DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix \
#                -v $HOME/MyWindNinjaRuns:/data:z \
#                --env="QT_X11_NO_MITSHM=1" \
#                --security-opt label=type:container_runtime_t \
#                windninja:3.7.5 
#
FROM windninja_prerequisites:latest

USER root
ADD . /opt/src/windninja/
SHELL [ "/usr/bin/bash", "-c" ]
ENV DEBIAN_FRONTEND noninteractive
ENV WM_PROJECT_INST_DIR /opt

RUN cd  /opt/src/windninja && \
    mkdir build && \
    cd  /opt/src/windninja/build && \
    cmake -D SUPRESS_WARNINGS=ON -D NINJAFOAM=ON -D NINJA_QTGUI=OFF -D NINJA_QT5GUI=OFF .. && \
    make -j4 && \
    make install && \
    ldconfig && \
    cd /opt/src/windninja && \
    /usr/bin/bash -c scripts/build_libs.sh

CMD /usr/bin/bash -c /usr/local/bin/WindNinja_cli
VOLUME /data
WORKDIR /data
