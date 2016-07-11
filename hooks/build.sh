#!/bin/bash
# See https://github.com/docker/hub-feedback/issues/508#issuecomment-222520720.
set -x
IMAGE_NAME=${IMAGE_NAME:-tecnativa/ocb:latest}

# Get only version name
version="$(echo $IMAGE_NAME | sed 's/.*://')"

if [ -z "$version" -o "$version" == "latest" ]; then
    version=9.0
fi

# Required PRs
cd ./addons/available/OCA/OCB
git remote add tecnativa-odoo https://github.com/Tecnativa/odoo.git
git fetch
git merge --no-edit \
    9.0-module-addons_path_len_reversed \
    9.0-translate-choose_right_path_with_similar_prefixes

# Now build it
cd ../../../..
docker build --build-arg ODOO_VERSION=$version -t $IMAGE_NAME .
