FROM debian:buster-slim
ENV SEAFILE_VER 7.1.4
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update
RUN apt-get install -y --no-install-recommends tar wget procps
RUN apt-get install -y --no-install-recommends python3.7 python3-setuptools python3-pil python3-ldap python3-urllib3 ffmpeg python3-pip sqlite3
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN pip3 install pillow moviepy

WORKDIR /seafile
VOLUME /seafile
EXPOSE 8000 8082 10001
COPY ["run.sh", "/bin/run.sh"]
ENTRYPOINT [ "bash", "run.sh" ]
