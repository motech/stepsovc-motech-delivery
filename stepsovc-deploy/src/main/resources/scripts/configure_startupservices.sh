echo "Adding postgres-9.1 to startup"
chkconfig  --level 0  postgresql-9.1 on
chkconfig  --level 1  postgresql-9.1 on
chkconfig  --level 2  postgresql-9.1 on
chkconfig  --level 3  postgresql-9.1 on
chkconfig  --level 4  postgresql-9.1 on
chkconfig  --level 5  postgresql-9.1 on
chkconfig  --level 6  postgresql-9.1 on

echo "Adding tomcat  to startup"

chkconfig  --level 0  tomcat on
chkconfig  --level 1  tomcat on
chkconfig  --level 2  tomcat on
chkconfig  --level 3  tomcat on
chkconfig  --level 4  tomcat on
chkconfig  --level 5  tomcat on
chkconfig  --level 6  tomcat on

echo "Adding HTTPD  to startup"
chkconfig  --level 0  httpd  on
chkconfig  --level 1  httpd  on
chkconfig  --level 2  httpd  on
chkconfig  --level 3  httpd  on
chkconfig  --level 4  httpd  on
chkconfig  --level 5  httpd  on
chkconfig  --level 6  httpd  on

echo "Adding Activemq to startup"
chkconfig  --level 0  activemq  on
chkconfig  --level 1  activemq  on
chkconfig  --level 2  activemq  on
chkconfig  --level 3  activemq  on
chkconfig  --level 4  activemq  on
chkconfig  --level 5  activemq  on
chkconfig  --level 6  activemq  on


echo "Removing  CouchDB  from startup"

chkconfig  --level 0  couchdb off
chkconfig  --level 1  couchdb off
chkconfig  --level 2  couchdb off
chkconfig  --level 3  couchdb off
chkconfig  --level 4  couchdb off
chkconfig  --level 5  couchdb off
chkconfig  --level 6  couchdb off


echo "Adding  Nagios to startup"

chkconfig  --level 0  nagios on
chkconfig  --level 1  nagios on
chkconfig  --level 2  nagios on
chkconfig  --level 3  nagios on
chkconfig  --level 4  nagios on
chkconfig  --level 5  nagios on
chkconfig  --level 6  nagios on

echo "Adding  memcached to startup"

chkconfig  --level 0  memcached on
chkconfig  --level 1  memcached on
chkconfig  --level 2  memcached on
chkconfig  --level 3  memcached on
chkconfig  --level 4  memcached on
chkconfig  --level 5  memcached on
chkconfig  --level 6  memcached on



