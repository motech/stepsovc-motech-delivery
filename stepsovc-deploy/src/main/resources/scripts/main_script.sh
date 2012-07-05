if [ $# -eq 0 ];
then
	echo 'Please pass the environment [qa or showcase or prod]'
else	
	if [ -f stepsovc-deploy-0.1-SNAPSHOT.jar ];
	then
		rm -f stepsovc-deploy-0.1-SNAPSHOT.jar
	fi

	if [ -d stepsovc_dest ];
	then
		rm -rf stepsovc_dest
	fi

	wget http://nexus.motechproject.org/content/repositories/snapshots/stepsovc-motech-delivery/stepsovc-deploy/0.1-SNAPSHOT/stepsovc-deploy-0.1-SNAPSHOT.jar
	mkdir stepsovc_dest
	cd stepsovc_dest
	jar -xf ../stepsovc-deploy-0.1-SNAPSHOT.jar

	echo '1. Full Redeploy of stepsovc(clears all db data and redeploys commcare and stepsovc web and runs full migration)'
	echo '2. Stepsovc web redeploy (only war redeploy)'
	echo '3. Commcare setup'
	echo '4. Migration only'

	read opt

	if [ $opt -eq 1 ];
	then
		cd scripts
		sh full_deploy_stepsovc.sh $1
	fi
	
	if [ $opt -eq 2 ];
	then
		ant -f deploy.xml -Denv=$1 deploy.stepsovc.from.nexus
	fi

	if [ $opt -eq 3 ];
	then
		cd scripts
		sh commcarehq_setup.sh
	fi
	
	if [ $opt -eq 4 ];
	then
		sh migration_full.sh $1
	fi
fi
