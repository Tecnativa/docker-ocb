#!/bin/env bash
set -ex
root=/opt/odoo
cd $(dirname $0)

# Control of background jobs. http://stackoverflow.com/a/38017902/1468388
fail () {
    touch .failure
}
expect () {
    wait
    test ! -f .failure
}

# Additional dependencies
yum -y install unzip libjpeg-turbo-devel zlib-devel libtiff-devel libfreetype-devel lcms2-devel libwebp-devel tcl-devel tk-devel || fail &
pip install --upgrade pip setuptools || fail &
expect

# Frozen dependencies per version
pip install --upgrade --no-cache --requirement \
    https://raw.githubusercontent.com/OCA/OCB/$ODOO_VERSION/requirements.txt \
    || fail &

process_row () {
    echo $1 -- $2 --- $3
    exit 1
    # Download file
    mkdir -p $2
    curl --location --output $2.zip $1

    # Unzip
    destination=$root/available/$2
    mkdir -p $destination
    unzip $2.zip -d $destination
    if [ -n "$(echo $1 | grep github.com)" ]; then
        # Remove extra folder inserted by GitHub
        garbage=$(ls $destination)
        mv $destination/*/* $destination
        rm -R $destination/$garbage
    fi

    # Remove .zip
    rm $2.zip

    # Link
    if [ "$3" == "all" ]; then
        ln -s $destination $root/extra-addons/

    # Special linking for OCB
    elif [ "$3" == "ocb" ]; then
        ln -s $destination/addons $root/extra-addons/OCB

        # Replace RPM Odoo for custom version
        rm -Rf /usr/lib/python2.7/site-packages/openerp
        ln -s $destination/openerp /usr/lib/python2.7/site-packages/
    fi
}

for row in $(cat list-$ODOO_VERSION.csv); do
    # Split by comma
    IFS=',' row=($row)

    # Expand variables
    row=$(eval echo $row)

    # Process the row in parallel
    process_row $row || fail &
done

# Compile Python modules
python -OO -m compileall -q $root || fail &

# Grant Odoo read and execute permissions
wait
chmod --recursive u=rwX,go=rX $root

# Clear unneeded stuff
yum -y remove unzip '*-devel'
yum clean all
