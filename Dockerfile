FROM ubuntu:23.04
RUN sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
RUN rm -f /etc/apt/apt.conf.d/docker-clean; echo 'Binary::apt::APT::Keep-Downloaded-Packages "true";' > /etc/apt/apt.conf.d/keep-cache
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt,sharing=locked \
    apt update && apt-get --no-install-recommends install -y git sqlite3  ssh cron
COPY ./init.sh /init.sh
WORKDIR /app
CMD ["/bin/bash", "/init.sh"]
