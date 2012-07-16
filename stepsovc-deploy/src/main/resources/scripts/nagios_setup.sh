#!/bin/sh

# Any Failing Command Will Cause The Script To Stop
set -e

# Treat Unset Variables As Errors
set -u

echo "**********install make**********"
yum -y install gcc automake autoconf libtool make

echo "**************Install mail *******************"
yum install  mailx

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


echo "---- Changing  Ownership--"
sudo chown --reference=/var/www/cgi-bin -R /usr/local/nagios/sbin
echo "---- Changing  Ownership done--"
ant -f stepsovc_dest/deploy.xml -Denv=$1 deploy-nagios-scripts
echo 'Please hit enter and change alias name and IP in localhost.cfg'
read opt
vi /usr/local/nagios/etc/objects/localhost.cfg
echo *******set  enforcing to permissive **************
setenforce 0
echo 'Please hit enter and set SELINUX=permissive'
read opt
vi /etc/selinux/config
echo "******Enter nagios admin password******"
htpasswd -c /usr/local/nagios/etc/htpasswd.users nagiosadmin
echo "*****Password set for username 'nagiosadmin'********"


echo  "****Installing  Sar  utility  for  CPU usage check"
echo "****Install crontabs*******"
yum install crontabs
echo "*****Install  SAR *****"
rpm -qa |grep sysstat-9.0.4-18.el6.x86_64>'$var'
if [ $var =="sysstat-9.0.4-18.el6.x86_64" ]
then
echo 'SAR already installed'
else
rpm -ivh ftp://mirror.switch.ch/pool/3/mirror/centos/6.2/os/x86_64/Packages/sysstat-9.0.4-18.el6.x86_64.rpm
fi
echo "*****SAR  Installed*****"


echo "HTTP  Configuration for  NAGIOS"
echo "Stopping HTTPD ..."
service httpd stop
echo "Add  (ProxyPass /nagios !) entry   to  HTTPD - **************"
echo "Please  hit  enter to  Add"
read opt
vi /etc/httpd/conf/httpd.conf
echo "Starting HTTPD ..."
service httpd start


echo "***** Starting Nagios"
chkconfig --add nagios
chkconfig nagios on
service nagios start

echo "***** Nagios Installation Done: " `date`

