sh drop_all_couchdb.sh
sh stop_all.sh
sh deploy_commcare.sh
cd ~/bootstepsovc
ant -f stepsovc_dest/deploy.xml -Denv=$1 recreatedb.and.deploy.stepsovc.from.hudson
sh start_all.sh
sh post_start.sh
sh migration_full.sh $1
