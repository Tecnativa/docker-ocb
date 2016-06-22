FROM yajo/odoo:9.0
MAINTAINER Tecnativa <info@tecnativa.com>

COPY scripts /tmp/

# Download and enable repositories
RUN yum -y install unzip &&\
    /tmp/default-addons.sh &&\
    rm -Rf /tmp/* &&\
    yum -y remove unzip &&\
    yum clean all
