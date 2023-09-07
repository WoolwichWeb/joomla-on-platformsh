#!/bin/bash
set -e

##
# Loop through template directories stored in git, copying them into web if
# they have been updated.
##

for d in templates/*; do
    [ -d "${d}" ] || continue;

    # Ensure templates directories are in place in the web directory.
    mkdir -p "web/${d}";

    echo "${d}: Checking for differences between version controlled and Joomla's template."

    if diff -urp "web/${d}" "${d}"; then
        echo "No differences between ${d} in git and Joomla."
    else
        echo
        echo "Syncing ${d} from git to Joomla."
        echo
        rsync -av --delete "${d}/" "web/${d}/"
    fi
done
