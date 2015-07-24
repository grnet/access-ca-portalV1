# Access CA Portal

## Overview

Access CA portal is a Ruby on Rails application created to support the users' authenticated registration and x509 personal and hosts' certificate issuance.

## Setup guide

> The following setup guide is aimed for a CentOS 7 installation. However, with not too much effort, it can be adjusted to other Linux distributions as well.

### Guide setup
| Software Element | Version |
|---|---|
| OS  | CentOS 7  |
| Ruby  | 1.8.7  |
| Rails | 2.3.8  |
| PostgreSQL  | 9.2  |
| WebServer | Apache 2.4.6 |
| MailServer | Postfix 2.10.2 |


### 1. Environment setup

```
sudo yum install -y git
sudo yum install -y vim
sudo yum install -y httpd
sudo yum install -y mod_ssl
sudo yum install -y curl-devel
sudo yum install -y httpd-devel
sudo yum install -y apr-devel
sudo yum install -y apr-util-devel
sudo yum install -y postfix

sudo yum install -y postgresql-server.x86_64
sudo yum install -y postgresql-devel.x86_64

sudo postgresql-setup initdb
sudo systemctl enable postgresql
sudo systemctl start postgresql
```

#### Database Initial Setup
```
# Change to postgres user
su postgres

# Create user and add password authentication
createuser <username>
psql
ALTER ROLE <username> WITH LOGIN;
\password <username>
\q
# change pg_hba.conf to have md5 authentication for the new user

# Create the access database with UTF-8 enconding
psql
# Create a template with UTF-8 encoding
UPDATE pg_database SET datistemplate = FALSE WHERE datname = 'template1';
DROP DATABASE template1;
CREATE DATABASE template1 WITH TEMPLATE = template0 ENCODING = 'UTF8';
UPDATE pg_database SET datistemplate = TRUE WHERE datname = 'template1';
\c template1;
VACUUM FREEZE;
CREATE DATABASE <access_database> owner=<username> encoding='UTF8' template=template1;

```

**Remeber** to change the identification method for the new user in pg_hba.conf


### 2. Install RVM

One should follow the steps described [here](https://rvm.io/rvm/install).

**Note:** for a **multiuser** installation of RVM, one must run the installation command with sudo. More information [here](https://rvm.io/support/troubleshooting/#sudo)

```
sudo gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3

\curl -sSL https://get.rvm.io | sudo bash

source /etc/profile.d/rvm.sh

usermod -a -G rvm <username>
```

In order for the user to be added to the group, logout and login again.

### 3. Install Ruby and gems

```
rvm install 1.8.7
rvm gemset create access-env
rvm use 1.8.7@access-env --default
```

```
gem install rails -v 2.3.8 --no-doc
gem install i18n -v 0.6.11 --no-doc
gem install pg -v 0.17.1 --no-doc

# for development/testing
gem install sqlite3 -v 1.3.10 --no-doc
```

### 4. Clone Repository

```
git clone https://github.com/grnet/access-ca-portal.git

cp -r access-ca-portal/access /var/www/access-ca-portal
```

### 5. Setup database configuration

```
cd /var/www/access-ca-portal
cp config/database.example database.yml
```

Edit the database configuration file with the options meeting your needs.
A sample for the postgresql database we installed would be:

**config/database.yml**
``` yml
development:
 adapter: sqlite3
 database: access_dev
 username: <username>
 password:
 host: localhost

production:
  encoding: utf8
  adapter: postgresql
  database: <access_production_database_name>
  username: <access_db_user>
  password: <access_db_pass>
  host: localhost

test:
  adapter: sqlite3
  database: <access_test_database_name>>
  username: <username>
  password:
  host: localhost
```

### DB migrations and pages population

#### Migration

```
export RAILS_ENV=production
rake db:migrate
```

#### Comatose pages db population

##### 1. Comment out the line:
**config/initializers/comatose.rb**
```
config.admin_authorization = :login_required
```
##### 2. Append the following in after the commented-out line:
```
config.admin_authorization = Proc.new do
  authenticate_or_request_with_http_basic do |username, password|
      username == "your_username_here" && password == "your_password_here"
  end
end
```
##### 3. In the **config/routes.rb** file uncomment the lines containing:
```
map.comatose_admin
map.comatose_root ''
```
##### 4. Run the rails server
```
script/server -p 3000
```
**Note:** Remember to open the port in iptables/firewalld in which you are running the server, at least temporarily.
##### 5. Populate comatose pages

* Visit http://your_hostname/comatose_admin
* Select Import>Choose file
* Point the file picker to the comatose.yml file contained inside the access project.  

##### 6. Fall back to the default configuration

Undo the changes introduced in steps 1-4.

### Setup Apache server

#### Install passenger for Apache

```
gem install passenger --no-doc
passenger-install-apache2-module
```

The last command will guide you through the whole process of installing Phusion Passenger on the target machine.

**Remember** to copy-paste the httpd configurations described after the installation of Passenger.

#### Modules required

* mod_rewrite
* mod_ssl
* mod_passenger

#### Access VirtualHost configuration

For configuring the httpd to run the access-ca-portal, we are creating a VirtualHost.
In order for this to work, we need to have a certificate issued by a trusted authority.
For testing purposes, one could issue a self-signed certificate and use it temporarily.

You can find the **ssl.conf.example** and **vhost_access.conf.exaple** template files in the **configurations/** directory of the repository.

**Note:** Remember to restart the httpd service in order for the changes to take place

### Setup mailer

A great part of the communication of Access CA Portal is the mail communication with its users/administrators. For this reason, we need a mailing system to be configured.

#### Postfix configurations

Depending on your environment, you can configure a local smtp server or use a relay-server.
After you complete the process, remember to start the postfix service and enable it at startup.

```
systemctl enable postfix
systemctl start postfix
```

#### Application configurations

All the configurations needed for the application to use the external mailing system, as well as the mail domain settings are described in the **config/environments/production.rb** file.

In case there is an external mailer to be used, please note that the relevant changes should be made in the aforementioned file.

#### Cronjobs

Under the directory **script/** there are the following ruby scripts that can be configured to run under crontab:

* CronChecks.rb
* notify_for_expiration.rb
* notify_for_certificate_expiration.rb
* notify_for_pending_requests.rb

## FAQ

### 1. undefined method source_index for Gem:Module

```
rake aborted!
undefined method `source_index' for Gem:Module
/var/www/access-ca-portal/config/../vendor/rails/railties/lib/rails/gem_dependency.rb:21:in `add_frozen_gem_path'
/var/www/access-ca-portal/config/boot.rb:47:in `load_initializer'
/var/www/access-ca-portal/config/boot.rb:38:in `run'
/var/www/access-ca-portal/config/boot.rb:11:in `boot!'
/var/www/access-ca-portal/config/boot.rb:110
/var/www/access-ca-portal/Rakefile:4
/usr/local/rvm/gems/ruby-1.8.7-head@access-env/bin/ruby_executable_hooks:15
```

#### Solution

```
rvm install rubygems 1.8.2 --force
```

More info [here](http://stackoverflow.com/questions/15349869/undefined-method-source-index-for-gemmodule-nomethoderror)

### 2. User DN is comma-separated and in different order

Simply add `+LegacyDNStringFormat` in the SSL options of the directory inside the Access VirtualHost apache configuration.

### 3. No access to specific resources

A common cause seems to be the SELinux if you have it enabled.
For example, for the httpd to have access to the database, you have to run the following command as root:

```
setsebool -P httpd_can_network_connect_db on
```
