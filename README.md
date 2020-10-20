# librenms_poller

- tested and developed on raspberry pi 3b+ running Ubuntu server 20.04 and ansible 2.9.10.

First thing is to install the posix collection to manage ACLs, run this if using ansible. Tower or AWX will pick this up automatically.

```
ansible-galaxy collection install -r collections/requirements.yml
```

Also, make sure you have pre-created your poller group on the core server in Settings>Poller>Poller Groups>Create new poller group.

Assumes memcached, redis, and rrdcached are all installed on your core server.

Needs to run with become in order to do all the things.

run playbook with command:

```
ansible-playbook -i hosts deploy_librenms_poller.yml -u <username> -b -K
```
