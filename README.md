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

Create a platform.sh site, selecting ‘Create from scratch’ on the ‘Select project type’ step. Make a note of the site id, then get the project (replace SITE_ID with the one Platform.sh gives you):

```bash
platform get SITE_ID
```

The above command should be on the Platform.sh project page. When run, it should ask which directory to put the site into, make a note of the directory name you chose.

Then clone this template repository and copy its contents into your new project:

```bash
git clone https://gitlab.com/woolwichweb/joomla-on-platformsh.git

# Copy the files from the 'Joomla! on Platform.sh' template into your project directory.
cp -r joomla-on-platformsh/{.platform,.platform.app.yaml,templates,web,.gitignore,php.ini} PLATFORM_SH_SITE_DIR/
```

If you have a custom Joomla! template, put it in the `templates` directory. For example, if you have a template called `my_template`, your directory structure would look like this:

```
-- PLATFORM_SH_SITE_DIR/
    |__ templates/
        |__ my_template/
            |__ index.php
            |__ templateDetails.xml
            |__ ... other files ...
```

Finally, commit the template and push to Platform.sh using git:

```bash
cd PLATFORM_SH_SITE_DIR
git add .
git commit -m "Initial commit of my Joomla! site."
platform push
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
platform mount:upload -m web --source . -y
platform redeploy -y
```

Finished! You may visit your new Joomla! site hosted on Platform.sh.

### Other instructions

When Joomla! updates itself, you can download the changes using this command:

```bash
platform mount:download --mount web --target web -y
```

If you need to copy a custom template from Joomla! to version control:

```bash
platform mount:download --mount web --target web -y
rsync -av --delete web/templates/TEMPLATE_NAME/ templates/TEMPLATE_NAME/
git add templates
git commit -m "Update custom template."
```
