ansible-jenkins-slave
====================

A role for installing jenkins-slave.

[![Build Status](https://api.travis-ci.org/AlbanAndrieu/ansible-jenkins-slave.png?branch=master)](https://travis-ci.org/AlbanAndrieu/ansible-jenkins-slave)

## Actions

- Ensures that jenkins-slave is installed (using `apt`)

Usage example
------------

```
  - name: Install jenkins-slave
    hosts: jenkins-slave
    user: root
  #  connection: local

    vars_files:
      - [ "roles/jenkins-slave/defaults/main.yml" ]
      - [ "roles/jenkins-slave/vars/{{ ansible_distribution }}-{{ ansible_architecture }}.yml", "roles/jenkins-slave/vars/{{ ansible_distribution }}.yml" ]
      
    roles:
      - jenkins-slave      
      
```

Requirements
------------

none

Dependencies
------------

https://travis-ci.org/Stouts/Stouts.jenkins

License
-------

MIT

#### Feedback, bug-reports, requests, ...

Are [welcome](https://github.com/AlbanAndrieu/ansible-jenkins-slave/issues)!
