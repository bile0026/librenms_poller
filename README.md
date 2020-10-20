# librenms_poller

default structure for ansible

First thing is to install the posix collection to manage ACLs, run this if using ansible. Tower or AWX will pick this up automatically.

```
ansible-galaxy collection install -r collections/requirements.yml
```

Also, make sure you have pre-created your poller group on the core server in Settings>Poller>Poller Groups>Create new poller group.
