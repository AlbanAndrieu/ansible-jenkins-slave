Docker
======

See ansible-jenkins-slave (https://registry/repositories/nabla/ansible-jenkins-slave/tags)

Pull image::

   docker pull registry/nabla/ansible-jenkins-slave

Start container::

   #Sample using container to buid my local workspace
   docker run -t -d -w /sandbox/project-to-build -v /workspace/users/albandri30/:/sandbox/project-to-build:rw --name sandbox registry/nabla/ansible-jenkins-slave:latest cat
   #More advance sample using jenkins user on my workstation in order to get bash completion, git-radar and most of the dev tools I need
   docker run -it -u 1004:999 --rm --net=host --pid=host --dns-search=albandrieu.com --init -w /sandbox/project-to-build -v /workspace/users/albandri30/:/sandbox/project-to-build:rw -v /workspace:/workspace -v /jenkins:/home/jenkins -v /etc/passwd:/etc/passwd:ro -v /etc/group:/etc/group:ro -v /etc/bash_completion.d:/etc/bash_completion.d:ro --name sandbox registry/nabla/ansible-jenkins-slave:latest /bin/bash
   #Now if I want to use my user albandri (1000) instead of jenkins
   docker run -it -u 1000:999 --rm --net=host --pid=host --dns-search=albandrieu.com --init -w /sandbox/project-to-build -v /workspace/users/albandri30/:/sandbox/project-to-build:rw -v /workspace:/workspace -v /data1/home/albandri/:/home/jenkins -v /etc/passwd:/etc/passwd:ro -v /etc/group:/etc/group:ro -v /etc/bash_completion.d:/etc/bash_completion.d:ro --name sandbox registry/nabla/ansible-jenkins-slave:latest /bin/bash

Build::

   docker exec sandbox /opt/maven/apache-maven-3.2.1/bin/mvn -B -Djava.io.tmpdir=./tmp -Dmaven.repo.local=/home/jenkins/.m2/.repository -Dmaven.test.failure.ignore=true -s /home/jenkins/.m2/settings.xml -f cmr/pom.xml clean install

Stop & remove container::

   docker stop sandbox
   docker rm sandbox

Build & development::

   ./run-ansible-workstation.sh` # for building like Jenkins.
   ./setup.sh` # for building.
   ./build.sh` # for building docker image.
