# librenms_poller

default structure for ansible

First thing is to install the posix collection to manage ACLs, run this if using ansible. Tower or AWX will pick this up automatically.

```
ansible-galaxy collection install -r collections/requirements.yml
```

Also, make sure you have pre-created your poller group on the core server in Settings>Poller>Poller Groups>Create new poller group.

Assumes memcached, redis, and rrdcached are all installed on your core server.

Needs to run with become in order to do all the things.
