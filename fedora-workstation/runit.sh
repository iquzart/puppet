#!/bin/bash


rpm -q puppet || sudo yum install -y puppet

sudo puppet apply --modulepath $(pwd)/modules -v fedora-workstation.pp
