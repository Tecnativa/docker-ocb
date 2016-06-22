# [WIP] Odoo with all OCA code (OCB + addon repositories)

## Usage

First of all, please read help for
[yajo/odoo](https://hub.docker.com/r/yajo/odoo/).

Now, on top of that, you have more features in this image.

### Additional features

The `/opt/odoo/available` folder, which holds a lot of code repositories,
python-compiled & optimized. The folder structure is `$USER/$REPO`. You have
BTW **all** OCA addon repositories under `/opt/odoo/available/OCA`.

`/opt/odoo/extra-addons` contains a handmade selection of repositories enabled
by default in all instalations. **Please do not ask us to change that**, this
is very specific to [Tecnativa][]. If you want to change it, fork & you know
the rest.

## To change the list of enabled repositories

Edit the [scripts/list.csv](https://github.com/Tecnativa/docker-ocb/blob/9.0/scripts/list.csv) file. It has these columns:

1. Path to zip package.
2. Path where to save (under `/opt/odoo/available`).
3. Addons to link in `/opt/odoo/extra-addons`. Currently, only the `all`
   keyword is supported, which will link the whole repository.

So yes, we download addons directly in `.zip` files to avoid Git overhead.


[Tecnativa]: https://www.tecnativa.com
