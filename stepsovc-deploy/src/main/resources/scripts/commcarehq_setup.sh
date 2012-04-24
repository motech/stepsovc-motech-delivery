echo '##########################################################'echo 'install dependencies of compare-hq'
echo '##########################################################'
yum install python-devel
yum install python-lxml
#install pg_config
yum install postgresql-devel


#install uglify-js
yum install npm
npm install uglify-js -g


#install nodejs and lessc
if [ -f nodejs-stable-release.noarch.rpm ];
then
     echo '**********nodejs-stable-release.noarch.rpm presents************'
else
     wget http://nodejs.tchol.org/repocfg/el/nodejs-stable-release.noarch.rpm
fi


yum localinstall --nogpgcheck nodejs-stable-release.noarch.rpm
yum install nodejs-compat-symlinks npm


if [ -d /opt/lessc ];
then
     echo '***************/opt/lessc presents***********'
else
     git clone https://github.com/cloudhead/less.js.git /opt/lessc
fi

#echo "alias lessc='nodejs /opt/lessc/bin/lessc'" >> ~/.bash_profile

#. ~/.bash_profile



#install pip

if [ -f ez_setup.py ];

then

     echo '***************pip is already installed***************'

else

     wget http://peak.telecommunity.com/dist/ez_setup.py

     python ez_setup.py

     easy_install pip

fi



echo '##########################################################'

echo 'create db and grant permission'

echo '##########################################################'



psql -U postgres -f dbcreate.sql



echo '##########################################################'

echo 'setup commcare-hq project'

echo '##########################################################'

if [ -d /var/log/datahq ];

then

     echo '*************datahq exists***********'

else

     mkdir /var/log/datahq

fi



if [ -d commcare-hq ];

then

     echo '********************compare-hq root exists*****************'

else

     git clone https://github.com/dimagi/commcare-hq.git

fi



if [ -f artifacts.zip ];

then

     echo 'Build file exists'

else

     wget http://build.dimagi.com:250/guestLogin.html?guest=1 http://build.dimagi.com:250/repository/downloadAll/bt52/11934:id/artifacts.zip

fi



cd commcare-hq

git submodule update --init --recursive

cat requirements.txt | sed s/lxml==2.3/lxml==2.2.3/ > temp

cat temp > requirements.txt

rm -f temp

pip install -r requirements.txt

cp localsettings.py.example localsettings.py

./manage.py syncdb

./manage.py migrate

./manage.py syncdb
./manage.py migrate./manage.py collectstatic
./manage.py createsuperuser
./manage.py make_bootstrap direct-lessc
python manage.py add_commcare_build ../artifacts.zip 1.3.0 7214


echo '##########################################################'
echo 'Create entry for localhost mapping'
echo '##########################################################'
psql -U postgres commcarehq -f ../sitecreate.sql


echo '##########################################################'
echo 'Deployment setup with cherrypy server'
echo '##########################################################'
cd submodules
git clone git://github.com/dimagi/django-cpserver.git


pip install cherrypy


echo 'comment JAR SIGN settings in localsettings.py'

echo 'add django_cpserver to INSTALLED_APPS in settings.py'

echo 'add django-cpserver to sys path in manage.py'

echo 'finally run the below command to start the server '
echo './manage.py runcpserver port=8000 host=<ip of the server>'

echo 'If you get "peer authentication failure " change pg_hba.conf of postgres 9.1.3 to "trust" local connection '

#echo '##########################################################'
#echo 'Deployment setup'
#echo '##########################################################'
##yum install httpd
##yum install mod_wsgi
##vi /etc/httpd/conf/httpd.conf