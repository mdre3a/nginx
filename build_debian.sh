#!/bin/bash

case "$1" in
    "")
        configure_arguments=$(nginx -V 2>&1 | grep -oP 'configure arguments: \K.*')
        bash -c "./auto/configure $configure_arguments"
        make -j $(nproc)
        ;;
    clean)
        make clean
        ;;
    install)
        if objs/nginx -t; then
            echo try to install...
            systemctl stop nginx
            cp objs/nginx /usr/sbin/nginx
            systemctl start nginx
        fi
        ;;
esac
