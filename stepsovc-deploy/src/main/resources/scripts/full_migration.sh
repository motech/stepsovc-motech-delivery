if [ -f stepsovc-deploy-0.1-SNAPSHOT.jar ];
then
        rm -f stepsovc-deploy-0.1-SNAPSHOT.jar
fi

if [ -d migration ];
then
        rm -rf migration
fi
wget http://nexus.motechproject.org/content/repositories/snapshots/stepsovc-motech-delivery/stepsovc-deploy/0.1-SNAPSHOT/stepsovc-deploy-0.1-SNAPSHOT.jar
mkdir migration
cd migration
jar -xf ../stepsovc-deploy-0.1-SNAPSHOT.jar
ant -f migrate.xml migrate.facility -Denv="prod"
ant -f migrate.xml migrate.caregiver -Denv="prod"
ant -f migrate.xml migrate.beneficiary -Denv="prod"
ant -f migrate.xml migrate.caregiver.phonenumber -Denv="prod"
ant -f migrate.xml migrate.facility.phonenumber -Denv="prod"
