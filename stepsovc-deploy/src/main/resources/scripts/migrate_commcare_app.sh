curl -X DELETE http://127.0.0.1:5984/commcarehq

python ~/projects/commcare-hq/manage.py syncdb
python ~/projects/commcare-hq/manage.py add_commcare_build ~/projects/artifacts.zip 1.3.0 7214

if [ -f commcare-mirror-0.1-SNAPSHOT.jar ];
then
	rm -f commcare-mirror-0.1-SNAPSHOT.jar
fi

if [ -d commcare_mirror_dest ];
then
	rm -rf commcare_mirror_dest
fi
wget http://nexus.motechproject.org/content/repositories/snapshots/stepsovc-motech-delivery/commcare-mirror/0.1-SNAPSHOT/commcare-mirror-0.1-SNAPSHOT.jar
mkdir commcare_mirror_dest
cd commcare_mirror_dest
jar -xf ../commcare-mirror-0.1-SNAPSHOT.jar
cp js/map.js ~/projects/commcare-hq/submodules/casexml-src/casexml/apps/case/_design/views/by_owner/map.js
ant mirror.commcare.db