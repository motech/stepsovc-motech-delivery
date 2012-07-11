if [ $# -eq 0 ];
then
    echo 'Please pass the environment[qa or showcase or prod, steps-ovc deploy repository[releases or snapshots] and version, steps-ovc repository and version'
    echo 'Ex:1'
    echo 'sh main_script.sh qa releases 1.1 releases 1.0'
    echo 'Ex:2'
    echo 'sh main_script.sh showcase snapshots 1.0-SNAPSHOT snapshots 1.0-SNAPSHOT'
else
	if [ -f stepsovc-deploy-$3.jar ];
	then
		rm -f stepsovc-deploy-$3.jar
	fi

	if [ -d stepsovc_dest ];
	then
		rm -rf stepsovc_dest
	fi

	wget http://nexus.motechproject.org/content/repositories/$2/stepsovc-motech-delivery/stepsovc-deploy/$3/stepsovc-deploy-$3.jar
	mkdir stepsovc_dest
	cd stepsovc_dest
	jar -xf ../stepsovc-deploy-$3.jar

    echo '1. Full Redeploy of stepsovc(clears all db data and redeploys commcare-hq and stepsovc web)'
    echo '2. Stepsovc web redeploy (only war redeploy)'
    echo '3. Commcare setup'
    echo '4. Migration only'

    read opt

    if [ $opt -eq 1 ];
    then
            cd scripts
            sh full_deploy_stepsovc.sh $1 $2 $3 $4 $5
    fi

    if [ $opt -eq 2 ];
    then
            ant -f deploy.xml -Denv=$1 -Dnexus.repo=$4 -Dnexus.version=$5 deploy.stepsovc.from.nexus
    fi

    if [ $opt -eq 3 ];
    then
            cd scripts
            sh commcarehq_setup.sh
    fi

    if [ $opt -eq 4 ];
    then
            cd scripts
            sh migration_full.sh $1 > ~/bootstepsovc/migration.log
    fi
fi