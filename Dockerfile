FROM yajo/odoo:9.0
MAINTAINER Tecnativa <info@tecnativa.com>

ARG ODOO_VERSION=9.0

COPY install /tmp/

# Download and enable repositories
RUN /tmp/install.sh && rm -Rf /tmp/*
