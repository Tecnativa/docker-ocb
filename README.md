# [WIP] Odoo with all OCA code (OCB + addon repositories)

[![Docker Stars](https://img.shields.io/docker/stars/tecnativa/ocb.svg?style=flat-square)](https://hub.docker.com/r/tecnativa/ocb)
[![Docker Pulls](https://img.shields.io/docker/pulls/tecnativa/ocb.svg?style=flat-square)](https://hub.docker.com/r/tecnativa/ocb)

## Usage

First of all, please read help for
[yajo/odoo](https://hub.docker.com/r/yajo/odoo/).

Now, on top of that, you have more features in this image.

### Additional features

The `/opt/odoo/available` folder, which holds a lot of code repositories,
python-compiled & optimized. The folder structure is `$USER/$REPO`. You have
BTW **all** OCA addon repositories under `/opt/odoo/available/OCA`.

`addons/enabled` contains a handmade selection of repositories enabled
by default in all instalations.

## Development

### Building

    ./hooks/build

### Updating addons

*Available* addons are git submodules, you can update all of them by:

    git submodule update --remote --recursive --init

*Enabled* addons are just symlinks to the *available* ones, so just add or
remove the symlinks and they will get into the docker image.

### Using this for development

You can use this image for development. First of all, clone it and activate its
submodules:

    git clone --recursive <url>
    cd <dir>

Now enter the `./env` directory and make copies of all `.sample` files wihthout
the `.sample` suffix, and replace variables in them. If you want to know what
each variable does, consult the docs for the image of the corresponding service
under `./development.yml`.

Whenever you need to make a PR for any of the submodules, you will want to add
your remote, make changes, push... just enter the submodule directory and work
as usual.

#### Useful commands

Start all containers:

    docker-compose -f development.yml up -d

Restart Odoo quickly (required when you change Python code):

    docker-compose -f development.yml restart -t0 odoo9

Output containers log to the console

    docker-compose -f development.yml logs -f --tail 50 # From all containers
    docker-compose -f development.yml logs -f odoo9 # Just from Odoo

Stop your whole environment:

    docker-compose -f development.yml stop

[Tecnativa]: https://www.tecnativa.com
