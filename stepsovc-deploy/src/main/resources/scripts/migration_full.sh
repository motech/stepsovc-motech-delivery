cd ~/bootstepsovc/stepsovc_dest
ant -f migrate.xml migrate.facility -Denv=$1
ant -f migrate.xml migrate.caregiver -Denv=$1
ant -f migrate.xml migrate.beneficiary -Denv=$1
ant -f migrate.xml migrate.caregiver.phonenumber -Denv=$1
ant -f migrate.xml migrate.facility.phonenumber -Denv=$1
ant -f migrate.xml create.case -Denv=$1