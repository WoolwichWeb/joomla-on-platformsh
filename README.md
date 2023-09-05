# Joomla! on Platform.sh

This guide and template should get you started running Joomla! 4 on platform.sh.

## Features

* Allows Joomla! access to its own files
* Keeps critical files in version control, and syncs them during deployments
* Uses Platform's configuration code to setup database access

## Requirements

* Command line
* Some devops experience, or desire to learn
* The `platform` command-line tool
* git

## Instructions

Create a platform.sh site, it shouldn't matter which type (basic PHP will be fine). Then clone it with git.

Delete all the files in that new site, and replace them with the files in this template (with the exception of the `.git` directory).

```bash
cd INSERT_PLATFORMSH_SITE_NAME_HERE
rm -r .platform .platform.app.yaml .lando.upstream.yml src web # Plus any other files.
```

Copy and paste the Joomla! source code into the `web` directory.



```bash

```