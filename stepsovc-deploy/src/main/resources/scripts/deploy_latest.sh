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

if [ $# -eq 0 ];
then
	echo 'Please pass the environment [qa or showcase or prod]'
else
    sh scripts/full_deploy_stepsovc.sh $1
fi