if [ $# -eq 0 ];
then
	echo 'Please pass the environment [qa or showcase or prod]'
else	
	if [ -f stepsovc-deploy-1.0.jar ];
	then
		rm -f stepsovc-deploy-1.0.jar
	fi

	if [ -d stepsovc_dest ];
	then
		rm -rf stepsovc_dest
	fi

	wget http://nexus.motechproject.org/content/repositories/release/stepsovc-motech-delivery/stepsovc-deploy/1.0/stepsovc-deploy-1.0.jar
	mkdir stepsovc_dest
	cd stepsovc_dest
	jar -xf ../stepsovc-deploy-1.0.jar

	echo '1. Full Redeploy of stepsovc(clears all db data and redeploys commcare-hq and stepsovc web)'
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
