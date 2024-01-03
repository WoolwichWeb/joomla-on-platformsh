# Joomla! on Platform.sh

This guide and template should get you started running Joomla! 5 on Platform.sh.

This template is maintained by [Woolwich Web Works](https://www.woolwichweb.works). We specialise in Web technologies like Drupal (and other Symfony based frameworks), Haskell, PureScript, and CSS.

This template is unofficial and not supported or endorsed by the Joomla! project.

## Features

* Provisions a new Joomla! 5 site automatically
* Allows Joomla! write access to its files, so self-update works
* Keeps templates in version control, and syncs them into Joomla! during deployments
* Integrates with Platform's configuration system for database access

## Requirements

* A command line, such as Bash or zsh
* Some devops experience, or desire to learn
* The `platform` command line tool
* Git

## Instructions

Create a platform.sh site, selecting ‘Create from scratch’ on the ‘Select project type’ step. Then run this command to get the project (replacing SITE_ID with the one Platform.sh gives you):

```bash
platform get SITE_ID
```

The above command, including `SITE_ID`, can be found on the Platform.sh console, on the page for your project. When run, it will ask which directory to put the site into, make a note of the directory name you choose.

Then run the following to clone this template repository, and copy its contents into your new project (change `PLATFORM_SH_SITE_DIR` to match the directory you noted above):

```bash
git clone https://gitlab.com/woolwichweb/joomla-on-platformsh.git

# Copy the template files into your project directory.
cp -r joomla-on-platformsh/{.platform,.platform.app.yaml,templates,bin,.gitignore,php.ini} PLATFORM_SH_SITE_DIR/
```

If you have a custom Joomla! template, put it in the `templates` directory. For example, if you have a template called `my_template`, your directory structure would look like this:

```text
-- PLATFORM_SH_SITE_DIR/
    |__ templates/
        |__ my_template/
            |__ index.php
            |__ templateDetails.xml
            |__ ... other files ...
```

Finally, commit the changes and push the project to Platform.sh.

This next step will download and install Joomla on the Platform.sh environment. If you already have a Joomla! site, you may wish to use that site's code. While instructions for using custom code are outside the scope of this document, it should be possible to achieve by commenting out any unwanted steps in `.platform.app.yaml`.

```bash
cd PLATFORM_SH_SITE_DIR
git add .
git commit -m "Initial commit of my Joomla! site."
platform push -y
```

### Finished

The installer will print the admin username, password and URL for your new site. If you need those details again, they will be in the deployment logs on Platform.sh (accessible through the console page for your project).

Precisely because the password is printed in plain text in the Platform.sh logs, changing it is highly recommended!

You may now download the provisioned Joomla! code to your local development machine:

```bash
platform mount:download --mount web --target web -y
```

### Other instructions

When Joomla! updates itself, those changes may be downloaded using this command:

```bash
platform mount:download --mount web --target web -y
```

When making custom template changes, make the changes to the template in `templates/TEMPLATE_NAME`, then commit them to git and push, Platform.sh will do the rest:

```bash
git add templates
git commit -m "Update TEMPLATE_NAME custom template."
platform push
```

This will keep a history of all the important changes to your Joomla! site's templates.

*Important Note*: templates in version control (`/templates`) will always overwrite those in `/web/templates`.

If you need to copy a custom template from Joomla! to version control:

```bash
platform mount:download --mount web --target web -y
rsync -av --delete web/templates/TEMPLATE_NAME/ templates/TEMPLATE_NAME/
git add templates
git commit -m "Add TEMPLATE_NAME custom template."
platform push
```
