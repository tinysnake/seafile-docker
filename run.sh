#!/bin/bash

set -c

SEAFILE_VER=7.1.5
INSTALL_DIR=seafile-server-${SEAFILE_VER}

if [ ! -d ${INSTALL_DIR} ]; then
    if [ ! -f "seafile-server_${SEAFILE_VER}_x86-64.tar.gz" ]; then
        wget --progress=dot:mega --no-check-certificate https://download.seadrive.org/seafile-server_${SEAFILE_VER}_x86-64.tar.gz
    fi
    tar -xzvf seafile-server_${SEAFILE_VER}_x86-64.tar.gz
    bash ${INSTALL_DIR}/setup-seafile.sh auto -n 'seafile' -i '0.0.0.0' -p '8082'
    sed -i 's/bind = "127.0.0.1:8000"/bind = "0.0.0.0:8000"/g' conf/gunicorn.conf.py
    if [[ (-n ${SEAFILE_ADMIN}) && (-n ${SEAFILE_ADMIN_PW}) ]]; then
        echo "setting up admin"
        sed -i 's/= ask_admin_email()/= '"\"${SEAFILE_ADMIN}\""'/' ${INSTALL_DIR}/check_init_admin.py
        sed -i 's/= ask_admin_password()/= '"\"${SEAFILE_ADMIN_PW}\""'/' ${INSTALL_DIR}/check_init_admin.py
    else
        echo "You forgot to set the ENV variable SEAFILE_ADMIN and SEAFILE_ADMIN_PW!"
    fi
fi

bash ${INSTALL_DIR}/seafile.sh start

while true; do
    if pgrep -f "seafile-controller" 2>&1 >/dev/null; then
        break
    fi
done
sleep 5

bash ${INSTALL_DIR}/seahub.sh start

while pgrep -f "seafile-controller" 2>&1 >/dev/null; do
    sleep 5
done
