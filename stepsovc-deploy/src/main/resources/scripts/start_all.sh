~/projects/commcare-hq/manage.py runcpserver host=192.168.42.33 port=8000 &
~/projects/commcare-hq/manage.py celeryd -v 2 -B -s celery -E -l INFO &