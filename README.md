# ansible-jenkins-slave

A role for installing jenkins-slave.


## Actions

- Ensures that jenkins-slave is installed (using `apt`)


## Usage:
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

## License

MIT
