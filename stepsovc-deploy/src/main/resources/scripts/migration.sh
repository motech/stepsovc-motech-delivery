if [ $# -ne 2 ];
then
    echo 'Please pass the env and csv file  path'
    echo 'Ex:1'
    echo 'sh migration.sh qa /root/projects/migration'
else
    echo 'Choose any of the  below to  start  migration'
    echo '1.Update Caregiver phonenumber and Facility'
    echo '2.Update Facility phonenumber'

    read opt

    if [ $opt -eq 1 ];
        then
             ant -f migrate.xml migrate.caregiver.phonenumber  -Denv=$1 -Dmigration.files.root=$2
    fi

    if [ $opt -eq 2 ];
        then
           ant -f migrate.xml migrate.facility.phonenumber  -Denv=$1 -Dmigration.files.root=$2
    fi
fi