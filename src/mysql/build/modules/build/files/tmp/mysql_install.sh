#!/bin/bash

apt-get update

debconf-set-selections <<< "mysql-community-server mysql-community-server/root-pass password container"

debconf-set-selections <<< "mysql-community-server mysql-community-server/re-root-pass password container"
debconf-set-selections <<< "mysql-community-server mysql-server/default-auth-override select Use Legacy Authentication Method (Retain MySQL 5.x Compatibility)"
DEBIAN_FRONTEND=noninteractive apt-get install -y mysql-server