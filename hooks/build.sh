#!/bin/bash
# See https://github.com/docker/hub-feedback/issues/508#issuecomment-222520720.
set -x

# Get only version name
version="$(echo $IMAGE_NAME | sed 's/.*://')"

if [ -z "$version" -o "$version" == "latest" ]; then
    version=9.0
fi

docker build --build-arg ODOO_VERSION=$version -t $IMAGE_NAME .
