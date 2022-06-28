#!/bin/bash

PROJECT_NAME="ngx_security_headers"
REPO_NAME="ray2019/nginx"
RELEASE_DIR="./docker";

for subVer in $RELEASE_DIR/*; do
    set -a
        . "$subVer/.env"
    set +a

    REPO_TAG="ngx-$NGINX_VERSION-$PROJECT_NAME-$MODULE_VERSION";
    BUILD_ARGS=$(tr '\n' ';' < "$subVer/.env" | sed 's/;$/\n/' | sed 's/^/ --build-arg /' | sed 's/;/ --build-arg /g')

    if [ -f "$subVer/Dockerfile" ]; then
        BUILD_NAME="$REPO_NAME:$REPO_TAG-alpine"
        if [[ "$(docker images -q $BUILD_NAME 2> /dev/null)" == "" ]]; then
            echo "Build: $BUILD_NAME";
            docker build $BUILD_ARGS --tag $BUILD_NAME -f $subVer/Dockerfile .
        fi
    fi

    if [ -f "$subVer/Dockerfile" ]; then
        BUILD_NAME="$REPO_NAME:$REPO_TAG"
        if [[ "$(docker images -q $BUILD_NAME 2> /dev/null)" == "" ]]; then
            echo "Build: $BUILD_NAME";
            docker build $BUILD_ARGS --tag $BUILD_NAME -f $subVer/Dockerfile .
        fi
    fi

done