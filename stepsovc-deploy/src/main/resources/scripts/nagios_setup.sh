#!/bin/sh

# Any Failing Command Will Cause The Script To Stop
set -e

# Treat Unset Variables As Errors
set -u

echo "***** Starting Nagios Quick-Install: " `date`
echo "***** Installing pre-requisites"
yum -y install httpd
yum -y install gcc
yum -y install glibc glibc-common
yum -y install gd gd-devel
yum -y install php

echo "***** Setting up the environment"
useradd -m nagios
passwd nagios
groupadd nagcmd
usermod -a -G nagcmd nagios
usermod -a -G nagcmd apache

echo "***** Getting the Nagios Source and Plug-Ins"
cd /usr/local/src
wget http://prdownloads.sourceforge.net/sourceforge/nagios/nagios-3.3.1.tar.gz
wget http://prdownloads.sourceforge.net/sourceforge/nagiosplug/nagios-plugins-1.4.15.tar.gz
tar xzf nagios-3.3.1.tar.gz
tar xzf nagios-plugins-1.4.15.tar.gz

echo "***** Installing Nagios"
cd /usr/local/src/nagios
./configure --with-command-group=nagcmd
make all
make install
make install-init
make install-config
make install-commandmode
make install-webconf

echo "***** Setting up htpasswd auth"
htpasswd -nb nagiosadmin password > /usr/local/nagios/etc/htpasswd.users
service httpd restart

echo "***** Setting up Nagios Plug-Ins"
cd /usr/local/src/nagios-plugins-1.4.15
./configure --with-nagios-user=nagios --with-nagios-group=nagios
make
make install

echo "***** Starting Nagios"
chkconfig --add nagios
chkconfig nagios on
service nagios start

echo "***** Done: " `date`