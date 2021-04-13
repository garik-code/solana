FROM ubuntu:latest

WORKDIR /
ENV DEBIAN_FRONTEND="noninteractive"
ENV TZ 'Europe/Moscow'
RUN apt-get update -y && \
    apt-get install -y tzdata make clang pkg-config libssl-dev build-essential ntp curl git libclang-dev wget
RUN echo $TZ > /etc/timezone && \
    rm /etc/localtime && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata
RUN ntpq -p
RUN cd /root && git clone https://github.com/solana-labs/solana && cd solana && export PATH=$PWD/bin:$PATH
CMD /root/solana
