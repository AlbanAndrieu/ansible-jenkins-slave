ansible-jenkins-slave
====================

A role for installing jenkins-slave.

[![Build Status](https://api.travis-ci.org/AlbanAndrieu/ansible-jenkins-slave.png?branch=master)](https://travis-ci.org/AlbanAndrieu/ansible-jenkins-slave)
[![Coverage Status](https://coveralls.io/AlbanAndrieu/ansible-jenkins-slave.png?branch=master)](https://coveralls.io/r/AlbanAndrieu/ansible-jenkins-slave?branch=master)

## Actions

- Ensures that jenkins-slave is installed (using `ansible`)
- Once jenkins-slave is installed using ansible, a docker image is automatically created, so please do not hesitate to enhance ansible script it will then improve docker image.

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
