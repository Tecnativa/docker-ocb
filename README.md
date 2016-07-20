# [WIP] Odoo with all OCA code (OCB + addon repositories)

## Usage

First of all, please read help for
[yajo/odoo](https://hub.docker.com/r/yajo/odoo/).

Now, on top of that, you have more features in this image.

### Additional features

The `/opt/odoo/available` folder, which holds a lot of code repositories,
python-compiled & optimized. The folder structure is `$USER/$REPO`. You have
BTW **all** OCA addon repositories under `/opt/odoo/available/OCA`.

`addons/enabled` contains a handmade selection of repositories enabled
by default in all instalations. **Please do not ask us to change that**, this
is very specific to [Tecnativa][]. If you want to change it, fork & you know
the rest.

## Development

### Shallow cloning with git

This repository uses submodules. To avoid slow clones and big disk usage:

    git clone --depth 1 --recursive https://github.com/Tecnativa/docker-ocb.git

### Updating addons

*Available* addons are git shallow submodules, the process is a bit different.
Let's assume you want to update the 9.0 branch:

    BRANCH=9.0
    git checkout $BRANCH
    git submodule foreach set-branches --add origin $BRANCH

    # Git >= 1.8.2
    git submodule update --remote --recursive --depth 1 --init  

    # Git < 1.8.2
    git submodule update --remote --recursive --depth 1 --init  
    git submodule foreach git reset --hard origin/$BRANCH

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

    docker-compose -f development.yml restart -t0 odoo8

Output containers log to the console

    docker-compose -f development.yml logs -f       # From all containers
    docker-compose -f development.yml logs -f odoo8 # Just from Odoo

Stop your whole environment:

    docker-compose -f development.yml stop

[Tecnativa]: https://www.tecnativa.com
