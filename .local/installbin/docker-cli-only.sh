#!/bin/bash 
DOCKERVERSION=27.5.1
#curl -fsSL https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKERVERSION}.tgz | 
#  tar tzv
TARGETDIR=${HOME}/.local/bin
echo "### Downloading and extracting docker into ${TARGETDIR}"
curl -fsSL https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKERVERSION}.tgz | 
  tar xzv --strip 1 -C ${TARGETDIR} docker/docker

ls -ld ${TARGETDIR}/docker
set -x
if ! which ssh-askpass; then
    echo "### Clearing sudo password to prevent silent install..."
    sudo -k
    echo "### Need to install ssh-askpass"
     sudo apt install ssh-askpass
fi
set +x

