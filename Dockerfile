FROM ubuntu:latest

WORKDIR /opt
ENV DEBIAN_FRONTEND="noninteractive"
ENV TZ 'Europe/Moscow'
RUN apt-get update -y && \
    apt-get install -y tzdata make clang pkg-config libssl-dev build-essential ntp curl git libclang-dev wget
RUN echo $TZ > /etc/timezone && \
    rm /etc/localtime && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata
RUN ntpq -p
RUN cd /opt && wget https://github.com/PlasmNetwork/Plasm/releases/download/v1.9.0-dusty/plasm-1.9.0-ubuntu-x86_64.tar.gz && \
               tar -xf plasm-1.8.0-ubuntu-x86_64.tar.gz
CMD /opt/plasm
