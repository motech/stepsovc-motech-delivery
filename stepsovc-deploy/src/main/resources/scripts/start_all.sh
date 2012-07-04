~/projects/commcare-hq/manage.py runcpserver host=localhost port=8000 &
~/projects/commcare-hq/manage.py celeryd -v 2 -B -s celery -E -l INFO &