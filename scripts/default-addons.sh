#!/bin/env bash
set -ex
root=/opt/odoo
cd $(dirname $0)

for row in $(cat list.csv); do
    # Split by comma
    IFS=',' row=($row)

    # Expand variables
    row=$(eval echo $row)

    # Download file
    mkdir -p ${row[1]}
    curl --location --output ${row[1]}.zip ${row[0]}

    # Unzip
    destination=$root/available/${row[1]}
    mkdir -p $destination
    unzip ${row[1]}.zip -d $destination
    if [ -n "$(echo ${row[0]} | grep github.com)" ]; then
        # Remove extra folder inserted by GitHub
        garbage=$(ls $destination)
        mv $destination/*/* $destination
        rm -R $destination/$garbage
    fi

    # Remove .zip
    rm ${row[1]}.zip

    # Link
    if [ "${row[2]}" == "all" ]; then
        ln -s $destination $root/extra-addons/

    # Special linking for OCB
    elif [ "${row[2]}" == "ocb" ]; then
        ln -s $destination/addons $root/extra-addons/OCB

        # Replace RPM Odoo for custom version
        rm -Rf /usr/lib/python2.7/site-packages/openerp
        ln -s $destination/openerp /usr/lib/python2.7/site-packages/
    fi
done

# Compile Python modules
python -OO -m compileall -q $root

# Grant Odoo read and execute permissions
chmod --recursive u=rwX,go=rX $root
