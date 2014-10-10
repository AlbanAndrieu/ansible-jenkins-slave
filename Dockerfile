# Ansible managed: /workspace/users/albandri10/env/ansible/roles/jenkins-slave/templates/Dockerfile.j2 modified on 2014-09-25 16:29:35 by albandri on albandri-laptop-misys
#FROM        debian:jessie
#FROM        stackbrew/ubuntu:14.04
FROM        jasongiedymin/ansible-base-ubuntu

# Volume can be accessed outside of container
VOLUME      [/var/lib/jenkins]

MAINTAINER  Alban Andrieu "https://github.com/AlbanAndrieu"

ENV			DEBIAN_FRONTEND noninteractive
ENV         JENKINS_HOME /var/lib/jenkins

# Working dir
WORKDIR /home/vagrant

# COPY
#COPY /workspace/users/albandri10/env/ansible/roles/jenkins-slave $WORKDIR

# ADD
ADD defaults $WORKDIR/defaults
ADD meta $WORKDIR/meta
ADD files $WORKDIR/files
#ADD handlers $WORKDIR/handlers
ADD tasks $WORKDIR/tasks
ADD templates $WORKDIR/templates
ADD vars $WORKDIR/vars
#ADD docker $WORKDIR/docker

# Here we continue to use add because
# there are a limited number of RUNs
# allowed.
ADD hosts /etc/ansible/hosts
ADD jenkins-slave.yml $WORKDIR/jenkins-slave.yml -vvvv

# Execute
#RUN         ansible-playbook $WORKDIR/jenkins-slave.yml -i $WORKDIR/hosts -c local
RUN         ansible-playbook jenkins-slave.yml -i hosts -c local

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
