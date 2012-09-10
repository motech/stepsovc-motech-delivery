filtered_logs=$(cat /home/steps-user/apache-tomcat-7.0.22/logs/stepsovc.log | grep -A`wc -l < /home/steps-user/apache-tomcat-7.0.22/logs/stepsovc.log` " - $1")
new_referrals=$(echo "$filtered_logs" | grep "Handling new" | grep -v "WVZ/TEST/00001" | awk '{ print $3" "$4" - "$12" - "$14 }')
new_referrals_count=$(echo  "$new_referrals" | grep "WVZ"| wc -l)
update_referrals=$(echo "$filtered_logs" | grep "Handling update referral" | grep -v "WVZ/TEST/00001" | awk '{ print $3" "$4" - "$12 }')
update_referrals_count=$(echo  "$update_referrals"| grep "WVZ" | wc -l)
update_services=$(echo "$filtered_logs" | grep "Handling update service" | grep -v "WVZ/TEST/00001" | awk '{ print $3" "$4" - "$12 }')
update_services_count=$(echo  "$update_services"| grep "WVZ" | wc -l)
no_of_sms=$(echo "$filtered_logs" | grep "SmsServiceImpl" | wc -l)
no_of_intimate=$(echo "$filtered_logs" | grep "SmsServiceImpl" | grep -i 'Due:\|Upcoming:\|Late:' | wc -l)
no_of_impending=$(echo "$filtered_logs" | grep "SmsServiceImpl" | grep "will be coming to your facility" | wc -l)
no_of_defaulted=$(echo "$filtered_logs" | grep "SmsServiceImpl" | grep "has not fulfilled the referral to" | wc -l)
no_of_unavailability=$(echo "$filtered_logs" | grep "SmsServiceImpl" | grep "will be closed from" | wc -l)
no_of_follow_up=$(echo "$filtered_logs" | grep "SmsServiceImpl" | grep "due for a visit today" | wc -l)
no_of_sms_sent=$(echo "$filtered_logs" | grep "\-success" | wc -l)
no_of_sms_failed=`expr $no_of_sms - $no_of_sms_sent`
echo "-------------------------------------------------------"
echo "New Referrals      : $new_referrals_count"
echo "Update Referrals   : $update_referrals_count"
echo "Update Services    : $update_services_count"
echo "-------------------------------------------------------"
echo "SMS sent           : $no_of_sms_sent"
echo "SMS failed         : $no_of_sms_failed"
echo "Total SMS          : $no_of_sms"
echo "Intimation to facility 		- $no_of_intimate"
echo "Alerts on impending referral 	- $no_of_impending"
echo "Referral Defaulited 		- $no_of_defaulted"
echo "Service Unavailability 		- $no_of_unavailability"
echo "Follow Up Reminder 		- $no_of_follow_up"
echo "-------------------------------------------------------"
echo "New Referrals :"
echo "$new_referrals"
echo "-------------------------------------------------------"
echo "Update Referrals :"
echo "$update_referrals"
echo "-------------------------------------------------------"
echo "Update Services :"
echo "$update_services"
echo "-------------------------------------------------------"