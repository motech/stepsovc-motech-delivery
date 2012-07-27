echo "started  migration at :"
date
cd ~/bootstepsovc/stepsovc_dest
ant -f migrate.xml migrate.facility -Denv=$1 -Dmigration.files.root=/root/bootstepsovc/stepsovc_dest/csv
ant -f migrate.xml migrate.caregiver -Denv=$1 -Dmigration.files.root=/root/bootstepsovc/stepsovc_dest/csv
ant -f migrate.xml migrate.beneficiary -Denv=$1 -Dmigration.files.root=/root/bootstepsovc/stepsovc_dest/csv
ant -f migrate.xml migrate.caregiver.phonenumber -Denv=$1 -Dmigration.files.root=/root/bootstepsovc/stepsovc_dest/csv
ant -f migrate.xml migrate.facility.phonenumber -Denv=$1 -Dmigration.files.root=/root/bootstepsovc/stepsovc_dest/csv
ant -f migrate.xml create.case
echo "ended  migration at"
date
