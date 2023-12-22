FROM ubuntu:23.04
RUN sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
RUN rm -f /etc/apt/apt.conf.d/docker-clean; echo 'Binary::apt::APT::Keep-Downloaded-Packages "true";' > /etc/apt/apt.conf.d/keep-cache
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt,sharing=locked \
    apt update && apt-get --no-install-recommends install -y git sqlite3  ssh cron
# git config set
RUN mkdir -p /root/.ssh && \
echo "StrictHostKeyChecking no" >> /root/.ssh/config && \
echo "UserKnownHostsFile /dev/null" >> /root/.ssh/config
COPY ./init.sh /var/run/init.sh
WORKDIR /app
CMD ["/bin/bash", "/var/run/init.sh"]
