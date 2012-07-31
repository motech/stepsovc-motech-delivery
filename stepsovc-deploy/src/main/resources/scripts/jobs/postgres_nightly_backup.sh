echo "starting to create postgres dump "
date
/usr/pgsql-9.1/bin/pg_dumpall -v -h localhost -p 5432 -U postgres>$(date +"%m-%d-%Y")-PGBACKUP
echo 'New postgres dump created'
mv -f $(date +"%m-%d-%Y")-PGBACKUP /var/lib/postgres_nightly_bk/
cd /var/lib/postgres_nightly_bk
if [ -f $(date --date=yesterday +%m-%d-%Y)-PGBACKUP ];
then
rm -rf  $(date --date=yesterday +%m-%d-%Y)-PGBACKUP
echo 'Old PG Dump Deleted'
fi
echo 'PG Dump - nightly backup taken successfully'
date