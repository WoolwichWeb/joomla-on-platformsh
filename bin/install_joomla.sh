#!/bin/bash
set -e

##
# Install Joomla! automatically into Platform.sh's environment.
##

admin_email='admin@example.com'
joomla_download_url='https://downloads.joomla.org/cms/joomla4/4-3-4/Joomla_4-3-4-Stable-Full_Package.zip?format=zip'

# Decode database and other variables from the Platform.sh environment.
rels=$(echo $PLATFORM_RELATIONSHIPS | base64 --decode);
db_host=$(echo $rels | jq -r ".database[0].host")
db_user=$(echo $rels | jq -r ".database[0].username")
db_pass=$(echo $rels | jq -r ".database[0].password")
db_name=$(echo $rels | jq -r ".database[0].path")
admin_pass=$(head -c 16 /dev/urandom | base64)
admin_url=$(echo $PLATFORM_ROUTES | base64 --decode | jq -r '.[] | select( .type == "upstream" ).production_url')

# Installation must be done from within the web root.
cd web

# Perform Joomla's automated installation.
# Note: the installer deletes itself after running successfully, so it is
# safe to run this on an installed site without any environment checks.
if test -d installation && test ! -f configuration.php; then
    php installation/joomla.php install \
        --no-interaction \
        --db-host=$db_host \
        --db-user=$db_user \
        --db-pass=$db_pass \
        --db-name=$db_name \
        --db-prefix=jos_ \
        --db-type=mysql \
        --admin-user=admin \
        --admin-username=admin \
        --admin-password="${admin_pass}" \
        --admin-email=admin@example.com \
        --site-name="My Joomla Site"

    # Enable URL rewriting.
    sed -i 's/public $sef_rewrite = false;/public $sef_rewrite = true;/' configuration.php \
        && echo "URL rewriting enabled." \
        && echo

    # Instructions for the user.
    echo "======================================================="
    echo
    echo "Username: admin"
    echo "Password: ${admin_pass}"
    echo
    echo "Log in here:"
    echo "${admin_url}administrator"
    echo
    echo "The admin user's e-mail is temporarily set to '${admin_email}'"
    echo "Please log in and change it at the address above."
    echo
    echo "======================================================="
fi
