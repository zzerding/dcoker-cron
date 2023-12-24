FROM ubuntu:23.04
RUN sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
RUN rm -f /etc/apt/apt.conf.d/docker-clean; echo 'Binary::apt::APT::Keep-Downloaded-Packages "true";' > /etc/apt/apt.conf.d/keep-cache
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt,sharing=locked \
    apt update && apt-get --no-install-recommends install -y git sqlite3  ssh cron curl
# git config set
RUN mkdir -p /var/run/script &&\
COPY ./init.sh /var/run/init.sh
WORKDIR /app
CMD ["/bin/bash", "/var/run/init.sh"]
