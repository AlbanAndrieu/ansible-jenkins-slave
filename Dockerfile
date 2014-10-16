# Ansible managed: /workspace/users/albandri10/env/ansible/roles/jenkins-slave/templates/Dockerfile.j2 modified on 2014-10-16 03:05:37 by albandri on albandri-laptop-misys
#FROM        debian:jessie
#FROM        stackbrew/ubuntu:14.04
FROM        jasongiedymin/ansible-base-ubuntu

# Volume can be accessed outside of container
VOLUME      [/var/lib/jenkins]

MAINTAINER  Alban Andrieu "https://github.com/AlbanAndrieu"

ENV			DEBIAN_FRONTEND noninteractive
ENV         JENKINS_HOME /var/lib/jenkins
ENV         WORKDIR /home/vagrant

# Working dir
WORKDIR /home/vagrant

# COPY
#COPY /workspace/users/albandri10/env/ansible/roles/jenkins-slave $WORKDIR

# ADD
ADD defaults $WORKDIR/ansible-jenkins-slave/defaults
ADD meta $WORKDIR/ansible-jenkins-slave/meta
ADD files $WORKDIR/ansible-jenkins-slave/files
#ADD handlers $WORKDIR/ansible-jenkins-slave/handlers
ADD tasks $WORKDIR/ansible-jenkins-slave/tasks
ADD templates $WORKDIR/ansible-jenkins-slave/templates
ADD vars $WORKDIR/ansible-jenkins-slave/vars

# Here we continue to use add because
# there are a limited number of RUNs
# allowed.
ADD hosts /etc/ansible/hosts
ADD jenkins-slave.yml $WORKDIR/ansible-jenkins-slave/jenkins-slave.yml

# Execute
RUN         pwd
RUN         ls -lrta
RUN         ansible-playbook $WORKDIR/ansible-jenkins-slave/jenkins-slave.yml -c local

#RUN         apt-get update && \
#            apt-get install -y openssh-server openjdk-7-jre-headless
#RUN         useradd -m -s /bin/bash jenkins
#RUN         echo jenkins:jenkins | chpasswd
#RUN         mkdir -p /var/run/sshd
            
EXPOSE      22
ENTRYPOINT  ["/etc/init.d/jenkins-swarm-client"]
#ENTRYPOINT ["java", "-jar", "/var/lib/jenkins/swarm-client-1.9-jar-with-dependencies.jar"]
CMD /usr/sbin/sshd -D
#CMD ["-g", "deamon off;"]
