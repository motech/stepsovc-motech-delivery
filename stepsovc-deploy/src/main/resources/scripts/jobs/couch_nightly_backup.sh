echo 'starting couchdb  nightly backup-' $date
date
cd /var/lib/couchdb_nightly_bk/
echo 'Coping the latest couchdb data from - /var/lib/couchdb_replication_bk'
mkdir $(date +"%m-%d-%Y")_couchdb
cp -R /var/lib/couchdb_replication_bk  $(date +"%m-%d-%Y")_couchdb/
if [ -f  $(date --date=yesterday +%m-%d-%Y)_couchdb ];
then
rm -rf  $(date --date=yesterday +%m-%d-%Y)_couchdb
echo '$(date --date=yesterday +%m-%d-%Y)_couchdb  Deleted!'
fi
echo 'couchdb nightly backup taken successfully'
date