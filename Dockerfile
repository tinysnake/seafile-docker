FROM debian:buster-slim
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update
RUN apt-get install -y --no-install-recommends tar wget procps
RUN apt-get install -y --no-install-recommends python3 python3-setuptools python3-pip sqlite3
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN pip3 --no-cache-dir install wheel 
RUN pip3 --no-cache-dir install pillow pylibmc captcha jinja2 sqlalchemy django-pylibmc django-simple-captcha python3-ldap

WORKDIR /seafile
VOLUME /seafile
EXPOSE 8000 8082
COPY ["run.sh", "/bin/run.sh"]
ENTRYPOINT [ "bash", "run.sh" ]
