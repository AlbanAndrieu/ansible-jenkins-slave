ansible-jenkins-slave
====================

A role for installing jenkins-slave.

[![Build Status](https://api.travis-ci.org/AlbanAndrieu/ansible-jenkins-slave.png?branch=master)](https://travis-ci.org/AlbanAndrieu/ansible-jenkins-slave)
[![Coverage Status](https://coveralls.io/AlbanAndrieu/ansible-jenkins-slave.png?branch=master)](https://coveralls.io/r/AlbanAndrieu/ansible-jenkins-slave?branch=master)
[![Galaxy](http://img.shields.io/badge/galaxy-jenkins-slave-blue.svg?style=flat-square)](https://galaxy.ansible.com/list#/roles/1998)
[![Tag](http://img.shields.io/github/tag/AlbanAndrieu/ansible-jenkins-slave.svg?style=flat-square)]()

## Actions 

- This role is more a sample than a real role has it is specific to my need. It can be used as a template.
- This role is used to test the link between docker https://registry.hub.docker.com/u/nabla/ansible-jenkins-slave/ and the Jenkins docker plugin
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
