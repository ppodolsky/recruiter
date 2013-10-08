Purpose
=======
These playbooks install the necessary packages and configurations to deploy
[Recruiter](https://github.com/jrhorn424/recruiter).

Playbooks
=========

## `bootstrap.yml`
Shameless ripped off from others. Modified from
[phred/5minbootstrap.git](https://github.com/phred/5minbootstrap.git) for ease
of customization and deployment.

In addition to setting up a newly provisioned Ubuntu 12.04 server, this playbook
adds the `postgresql` repository and sets up keys.

This should be the only playbook run as root, as it disables root logon via ssh.

###Instructions
#### Set the root password
Run:

    yourmachine$ ssh root@server

Enter the initial root password from your hosting provider, then run:

    root@server# passwd

#### Update the SSH public key.
Make sure your public key is available for upload in the `files` subdirectory
the `new` role. Edit the `deploy_user` task to match the name of the file.

####  Run the playbook
If you are logging into a fresh Linode, or another sytem where you only have the
`root` user, you need to run with the `--ask-pass` flag. Only pass `ssh=true` if
you want to disable root logon over ssh. It will also **disable password
authentication**. You'll need to pass in the host, as well.

    yourmachine$ ansible-playbook -i hosts.ini new.yml --user root --ask-pass --extra-vars "ssh=true hosts=ices"

## `site.yml`
This playbook makes sure our app can run by installing dependencies. For
example, it installs `chruby` and our desired `ruby`, and makes sure that is our
default `ruby`. It also installs nginx and uploads the configuration, linking
them into `sites-available` before restarting `nginx`. Finally, it sets up our
database server and initializes a database, if `db=true` is passed. If
`dotfiles=true` is passed, homeshick will be installed and dotfiles cloned.

### Run the playbook

    ansible-playbook -i hosts.ini site.yml --extra-vars "db=true dotfiles=true hosts=weber"
