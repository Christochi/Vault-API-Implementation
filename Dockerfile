# Docker-Vault-Image

# base image
FROM ubuntu

# update packages & install git
RUN apt-get update

# install git and clone repo from github
RUN apt-get install -y git && \
git clone https://github.com/Christochi/terraform-vault-engine-auth.git

# install wget & unzip
RUN apt-get install -y wget && apt-get install unzip 

# install vault & set the PATH
RUN wget https://releases.hashicorp.com/vault/1.13.0/vault_1.13.0_linux_386.zip
RUN unzip vault_1.13.0_linux_386.zip -d /usr/local/bin

# install golang and set the PATH
RUN wget https://go.dev/dl/go1.20.2.linux-amd64.tar.gz 
RUN tar -C /usr/local -xzf go1.20.2.linux-amd64.tar.gz && \
echo "export PATH=$PATH:/usr/local/go/bin" >> ~/.bashrc