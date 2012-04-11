service couchdb stop
if [ -f cp /var/lib/couchdb/commcarehq.couch ];
then
mv /var/lib/couchdb/commcarehq.couch /var/lib/couchdb/commcarehq.couch_bkp
fi

cp ../couchdb/commcarehq.couch  /var/lib/couchdb/commcarehq.couch
sudo chown couchdb:couchdb /var/lib/couchdb/commcarehq.couch
service couchdb start