cd ~/projects/commcare-hq
service memcached start
./manage.py runcpserver host=0.0.0.0 port=8000 &
service celeryd start