# seafile-docker
The official seafileltd/seafile docker lacks documentation and seafile version is quite old to this date.
So I created a seafile-docker is small and simple enough to setup for people who wants to create a personal cloud storage.

Note: This docker uses **gunicorn** as the HTTP server and **sqlite3** as database to reduce complication, they are pretty sufficient for personal use.

Current seafile-server version is: **7.0.5**

# How to setup

Simply follow the command down below:

```
docker run -d --name seafile \
-p 8000:8000 \
-p 8082:8082 \
-v /your/seafile/directory:/seafile \
-e SEAFILE_ADMIN="your@email.address" \
-e SEAFILE_ADMIN_PW="your_password" \
tinysnake/seafile
```

After the docker container was setup, the container will download the latest version of seafile-server and deploy itself, so I can take a minute, please be patience.

When the docker container is done the file structure will be like:

```
/your/seafile/directory
  |-ccnet
  |-conf
  |-logs
  |-pids
  |-seafile data
  |-seafile-server-xxx
  |-seahub-data
  |-seahub.db
```

Now you can access your seafile web gui through port 8000.

You better change the admin password after the docker container was setup.