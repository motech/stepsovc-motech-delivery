service tomcat stop
service memcached stop
kill `ps -ef | grep celery | grep -v grep | awk '{print $2}'`
kill `ps -ef | grep runcpserver | grep -v grep | awk '{print $2}'`
