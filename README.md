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


[Tecnativa]: https://www.tecnativa.com
