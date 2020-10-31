# librenms_poller

- tested and developed on raspberry pi 3b+ (should work work on a RP 4) running Ubuntu server 20.04/Raspbian Stretch & Buster, using ansible 2.9.10. Also tested on CentOS 8 (x86).
- Make sure to deploy from tags as master branch should be considered development/experimental.

# Current issues:

- rrdcached seems to have an issue on ubuntu 20.04.1. Not sending rrd files to core.
- still working out details on how to authorize poller to the mariadb instance on the core server, for now have to do this manually
- Disabled SELinux on RedHat-based systems until I have time to do the proper policies
- using shell for dnf PHP commands on RedHat, once dnf_module is released need to update to this
- Possibly convert librenms php composer script to use ansible modules

# Pre-setup tasks

```
GRANT ALL PRIVILEGES ON librenms.* TO 'librenms'@'IP_OF_NEW_POLLER' IDENTIFIED BY 'The_Password_You_Chose' WITH GRANT OPTION;
```

or, less secure, allow login with that user from any IP

```
GRANT ALL PRIVILEGES ON librenms.* TO 'librenms'@'%' IDENTIFIED BY 'The_Password_You_Chose' WITH GRANT OPTION;
```

First thing is to install the posix collection to manage ACLs, run this if using ansible. Tower or AWX will pick this up automatically.

```
ansible-galaxy collection install -r collections/requirements.yml
```

Also, make sure you have pre-created your poller group on the core server in Settings>Poller>Poller Groups>Create new poller group.

Assumes memcached, redis, and rrdcached are all installed on your core server.

Needs to run with become in order to do all the things.

# Run Playbook

run playbook with command:

```
ansible-playbook -i hosts deploy_librenms_poller.yml -u <username> -b -K
```

vars to set (defaults):

```
webserver: nginx (nginx or apache, nginx reccomended)
time_zone: America/Chicago (your timezone)
php_version: 7.4 # for debian installs
rrdcached_version: 1.7.0 # needs to match core server
mysql_user: librenms (password for mysql database on core server)
mysql_password: librenms (password for mysql database on core server)
mysql_db: librenms (mysql database name on core server)
poller_ip: 192.168.20.253 (ip address of your poller device)
poller_name: test-pi (name of the poller)
poller_group_number: 2 (poller group member, make sure groups is created in core first)
core_server_fqdn: 192.168.252.58 (ip or fqdn of your core server)
snmp_string: public (default snmp string for the poller)
app_key: 123456 (APP_KEY from /opt/librename/.env from your core server)
auto_scan_subnets: (subnets included in automatic discovery)
  - 192.168.0.0/24
  - 192.168.1.0/24
exclude_scan_subnets: (subnets excluded from automatic discovery)
  - 192.168.0.1/32
  - 192.168.1.1/32
```
