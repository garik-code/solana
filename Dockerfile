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
RUN apt-get install cargo -y
RUN apt-get install screen -y
RUN git clone https://github.com/solana-labs/solana
RUN /solana/scripts/cargo-install-all.sh . && export PATH=$PWD/bin:$PATH && solana-install init
RUN screen
CMD /opt/solana
