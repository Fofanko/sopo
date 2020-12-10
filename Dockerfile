FROM ubuntu:18.04

# Install apt packages
RUN apt-get update; apt-get --assume-yes install python3 \
    python3-nacl python3-pip libffi-dev python3-pip git
# Install ansible from pip
RUN pip3 install ansible
# Create dir for ansbile files
RUN mkdir /root/sopo 
WORKDIR /root/sopo
# Fill files to ansbile dir
ADD ./enviroments enviroments/
ADD ./playbooks playbooks/
ADD ./roles roles
ADD ./ansible.cfg ansible.cfg

RUN ansible-galaxy install -r roles/requirements.yml

ENTRYPOINT ansible-playbook -i enviroments/dev/inventory playbooks/start-app.yml -D -vv