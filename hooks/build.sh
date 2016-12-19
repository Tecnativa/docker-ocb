#!/bin/bash
# See https://github.com/docker/hub-feedback/issues/508#issuecomment-222520720.
set -ex
IMAGE_NAME=${IMAGE_NAME:-tecnativa/ocb:latest}
DIR="$(pwd)"

# Get only version name
version="$(echo $IMAGE_NAME | sed 's/.*://')"

if [ -z "$version" -o "$version" == "latest" ]; then
    version=9.0
fi

# Configure Git, required for merges as they emit a commit
git config --global user.name "Tecnativa's Docker Hub Bot"
git config --global user.email info@tecnativa.com

# Merge required pull request
merge_pr () {
    cd $DIR/addons/available/OCA/$1
    git fetch origin pull/$2/head:pr$2
    git merge --no-edit pr$2
}

merge_pr reporting-engine 88

# Now build it
docker build --build-arg ODOO_VERSION=$version -t $IMAGE_NAME "$DIR"
