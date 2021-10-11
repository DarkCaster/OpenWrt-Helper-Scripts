#!/bin/bash

set -e

script_dir="$( cd "$( dirname "$0" )" && pwd )"
cd "$script_dir"

rm -fv ssh.key ssh.key.pub
# ssh-keygen -t rsa -b 4096 -m PEM -f ssh.key
# ssh-keygen -b 521 -t ecdsa -f ssh.key
ssh-keygen -t ed25519 -f ssh.key
ssh-keygen -c -C "remote@admin" -f ssh.key
