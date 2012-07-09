mv -f /var/lib/couchdb/commcarehq.couch /var/lib/couchdb/commcarehq.couch_bkp
curl -X DELETE http://localhost:5984/commcarehq
psql -U postgres -f ~/bootstepsovc/stepsovc_dest/sql/dbrecreate.sql

cd ~/projects/commcare-hq/
python ~/projects/commcare-hq/manage.py syncdb
python ~/projects/commcare-hq/manage.py migrate
python ~/projects/commcare-hq/manage.py collectstatic
python ~/projects/commcare-hq/manage.py createsuperuser
python ~/projects/commcare-hq/manage.py bootstrap stepsovc stepsovc@worldvision.com 1234
python ~/projects/commcare-hq/manage.py make_bootstrap direct-lessc node
psql -U postgres commcarehq -f ~/bootstepsovc/stepsovc_dest/sql/postdbcreate_$1.sql
python ~/projects/commcare-hq/manage.py add_commcare_build ~/projects/artifacts.zip 1.3.0 7214

cd ~/bootstepsovc

if [ -f commcare-mirror-$3.jar ];
then
	rm -f commcare-mirror-$3.jar
fi

if [ -d commcare_mirror_dest ];
then
	rm -rf commcare_mirror_dest
fi
wget http://nexus.motechproject.org/content/repositories/$2/stepsovc-motech-delivery/commcare-mirror/$3/commcare-mirror-$3.jar
mkdir commcare_mirror_dest
cd commcare_mirror_dest
jar -xf ../commcare-mirror-$3.jar
ant mirror.commcare.db
cd ..