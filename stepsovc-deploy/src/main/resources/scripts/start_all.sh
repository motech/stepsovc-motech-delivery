cd ~/projects/commcare-hq
./manage.py runcpserver host=0.0.0.0 port=8000 &
./manage.py celeryd -v 2 -B -s celery -E -l INFO &