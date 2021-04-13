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
RUN sh -c "$(curl -sSfL https://release.solana.com/v1.6.4/install)" && export PATH="/root/.local/share/solana/install/active_release/bin:/root/.local/share/solana/install/active_release/bin"
CMD /root
