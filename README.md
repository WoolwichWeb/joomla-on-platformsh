# Joomla! on Platform.sh

This guide and template should get you started running Joomla! 4 on platform.sh.

## Features

* Allows Joomla! write access to its files, so self-update works
* Keeps important files in version control, and syncs them into Joomla! during deployments
* Integrates with Platform's configuration system for database access

## Requirements

* Command line
* Some devops experience, or desire to learn
* The `platform` command-line tool
* Git

## Instructions

Create a platform.sh site, the type doesn't matter, but these instructions are based on the basic PHP template. Then clone that site onto your development machine, using git.

Having cloned it, delete all the files in that new site, and replace them with the files in this template (with the exception of the `.git` directory). For example:

```bash
cd INSERT_PLATFORMSH_SITE_NAME_HERE
rm -r .platform .platform.app.yaml .lando.upstream.yml src web # Plus any other files (but keep .git).
```

Then clone this template repository:

```bash
cd .. # Move out of your project directory
git clone https://gitlab.com/woolwichweb/joomla-on-platformsh.git

# Copy the files from the 'Joomla! on Platform.sh' template into your project directory.
cp -r joomla-on-platformsh/{.platform,.platform.app.yml,templates,web,.gitignore,README.md,php.ini} INSERT_PLATFORMSH_SITE_NAME_HERE/
```

If you have a custom Joomla! template, put it in the `templates` directory. For example, if you have a template called `my_template`, your directory structure would look like this:

```
-- INSERT_PLATFORMSH_SITE_NAME_HERE/
    |__ templates/
        |__ my_template/
            |__ index.php
            |__ templateDetails.xml
            |__ ... other files ...
```

Finally, commit the template and push to Platform.sh using git:

```bash
cp INSERT_PLATFORMSH_SITE_NAME_HERE
git add .
git commit -m "Initial commit of Platform.sh template for Joomla!"
git push
```

Note: this will not make a working site, yet.

Copy and paste the latest version of Joomla! into the `web` directory. For example:

```bash
cd web
wget https://github.com/joomla/joomla-cms/releases/download/4.3.4/Joomla_4.3.4-Stable-Full_Package.tar.bz2
tar -xjf Joomla_4.3.4-Stable-Full_Package.tar.bz2
rm Joomla_4.3.4-Stable-Full_Package.tar.bz2
```

Substitute '4.3.4' for the latest version of Joomla!

If you already have a Joomla! site, you may use that instead (instructions for that are outside the scope of this document).

Upload Joomla! and deploy it to Platform.sh:

```bash
platform mount:upload -m web --source web -y
platform redeploy -y
```

When Joomla! updates itself, you can download the changes using this command:

```bash
platform mount:download --mount web --target web -y
```
