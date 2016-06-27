FROM yajo/odoo:9.0
MAINTAINER Tecnativa <info@tecnativa.com>

ARG ODOO_VERSION=9.0

COPY addons/available /opt/odoo/available
COPY addons/enabled /opt/odoo/extra-addons

# Compile Python modules
RUN python -OO -m compileall -q /opt/odoo/available &&\

    # Grant Odoo read permission
    chmod --recursive u=rwX,go=rX /opt/odoo/available &&\

    # Replace packaged Odoo for downloaded OCB
    rm -Rf /usr/lib/python2.7/site-packages/openerp &&\
    ln -s /opt/odoo/available/OCA/OCB/openerp /usr/lib/python2.7/site-packages/
