sh drop_all_couchdb.sh
sh stop_all.sh
sh deploy_commcare.sh $1
cd ~/bootstepsovc/stepsovc_dest
ant -f deploy.xml -Denv=$1 recreatedb.and.deploy.stepsovc.from.nexus
cd scripts
echo 'Press Enter to start celery and commcare-hq in the background. You may then close the terminal.'
read opt
sh start_all.sh
sh post_start.sh
#sh migration_full.sh $1
