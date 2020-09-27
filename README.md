# seafile-docker

## Introduction

The official seafileltd/seafile docker lacks documentation and seafile version is quite old to this date.
So I created a seafile-docker is small and simple enough to setup for people who wants to create a personal cloud storage.

Note: This docker uses **gunicorn** as the HTTP server and **sqlite3** as database to reduce complication, they are pretty sufficient for personal use.

Current seafile-server version is: **7.1.5**

## Warning

The Version 7.1.x is not natively compatible with 7.0.x, You need to run some command to upgrde from 7.0.x to 7.1.x, go to the Upgrade Section for more info.

## Setup

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

## Forgot to set SEAFILE_ADMIN and SEAFILE_ADMIN_PW

Run these commands:

```
docker exec -it seafile bash

bash seafile-server-${SEAFILE_VER}/reset-admin.sh
```

Then press `ctrl+D` to get out.

## Upgrade

### From 7.0.x to 7.1.x

First, stop your running 7.0.x seafile container.
type these commands in the terminal:

```
docker container stop seafile
docker pull tinysnake/seafile-docker:7.1
docker run -it --rm -v your/seafile/directory:/seafile --entrypoint bash tinysnake/seafile-docker:7.1
bash ./seafile-server-${SEAFILE_VER}/upgrade/upgrade_7.0_7.1.sh
```

Command line will prompt you to press ENTER to continue, just do what it says.

You will see `Upgraded your seafile server successfully`, when the upgrade when right.

Then press `ctrl+D` to get out.

Delete the old 7.0.x docker container, and run this command:

```
docker run -d --name seafile \
-p 8000:8000 \
-p 8082:8082 \
-v /your/seafile/directory:/seafile \
tinysnake/seafile:7.1
```