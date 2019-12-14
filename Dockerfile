FROM debian:buster-slim
ENV SEAFILE_VER 7.0.5
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update
RUN apt-get install -y --no-install-recommends tar wget procps
RUN apt-get install -y --no-install-recommends python2.7 libpython2.7 python-setuptools python-pil python-ldap python-urllib3 ffmpeg python-pip sqlite3
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN pip install pillow moviepy

WORKDIR /seafile
VOLUME /seafile
EXPOSE 8000 8082
COPY ["run.sh", "/bin/run.sh"]
ENTRYPOINT [ "bash", "run.sh" ]