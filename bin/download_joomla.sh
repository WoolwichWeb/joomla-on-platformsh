#!/bin/bash
set -e -x

joomla_download_url='https://downloads.joomla.org/cms/joomla5/5-0-3/Joomla_5-0-3-Stable-Full_Package.zip?format=zip'

cd web

# Download Joomla! to the web directory, if necessary.
if ! find . -mindepth 1 -maxdepth 1 | read; then
    wget -q "${joomla_download_url}" -O joomla.zip && unzip -q -n joomla.zip
    rm joomla.zip
fi
