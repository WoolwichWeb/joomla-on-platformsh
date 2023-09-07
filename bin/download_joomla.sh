#!/bin/bash
set -e

cd web

# Download Joomla! to the web directory, if necessary.
if ! find . -mindepth 1 -maxdepth 1 | read; then
    wget -q "${joomla_download_url}" -O joomla.zip && unzip -q -n joomla.zip
    rm joomla.zip
fi
