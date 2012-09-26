import smtplib
from email.MIMEMultipart import MIMEMultipart
from email.MIMEBase import MIMEBase
from email.MIMEText import MIMEText
from email.Utils import COMMASPACE, formatdate
from email import Encoders
import os
from datetime import datetime, timedelta
from datetime import date
import couchdb
import operator

new_referrals = []
update_referrals = []
update_services = []
caregiver_with_max_referral = []
facility_with_max_referral = []
no_of_intimate = 0
no_of_impending = 0
no_of_defaulted = 0
no_of_unavailability = 0
no_of_follow_up = 0
total_sms = 0
caregiver_map = {}
facility_map = {}
stepsovcdb = None

def sendMail(to, fro, subject, text,server="localhost"):
	assert type(to)==list
	msg = MIMEMultipart()
	msg['From'] = fro
	msg['To'] = COMMASPACE.join(to)
	msg['Date'] = formatdate(localtime=True)
	msg['Subject'] = subject
	msg.attach( MIMEText(text, 'html') )
	print 'connecting to server...'
	smtp = smtplib.SMTP(server)
	print 'sending email...'
	smtp.sendmail(fro, to, msg.as_string() )
	print 'sent.'
	smtp.close()

def gatherReport(for_days, log_loc, couch_url):

	global stepsovcdb, new_referrals, update_referrals, update_services, caregiver_with_max_referral, facility_with_max_referral, no_of_intimate, no_of_impending, no_of_defaulted, no_of_unavailability, no_of_follow_up, total_sms, caregiver_map, facility_map
	
	couch = couchdb.Server(couch_url)
	stepsovcdb = couch["stepsovc"]
	map_fun = '''function(doc) {if(doc.type == 'Caregiver') emit([doc.code],[doc.firstName,doc.lastName]) }'''
	date_list = []
	required_log_list = ["Handling new", "Handling update referral", "Handling update service", "SmsServiceImpl"]
	filtered_logs = []

	from_day = date.today() - timedelta(1)	

	for single_date in (from_day - timedelta(n) for n in range(for_days)):
        date_list.append(" - " + single_date.isoformat())
	
	if(os.path.exists(log_loc+"stepsovc.log.1")):
        for line in open(log_loc+"stepsovc.log.1"):
            if any(required in line for required in required_log_list) and any(date in line for date in date_list):
                filtered_logs.append(line.rstrip())
	
	for line in open(log_loc+"stepsovc.log"):
		if any(required in line for required in required_log_list) and any(date in line for date in date_list):
			filtered_logs.append(line.rstrip())
	
	new_referrals_logs = filter(lambda line: "Handling new" in line, filtered_logs)
	update_referrals_logs = filter(lambda line: "Handling update referral" in line, filtered_logs)
	update_services_logs = filter(lambda line: "Handling update service" in line, filtered_logs)
	sms_logs = filter(lambda line: "SmsServiceImpl" in line, filtered_logs)
	
	new_referrals = map(lambda line: [line.split(" ")[2], line.split(" ")[3], line.split(" ")[11], line.split(" ")[13]], new_referrals_logs)
	update_referrals = map(lambda line: [line.split(" ")[2], line.split(" ")[3], line.split(" ")[11]], update_referrals_logs)
	update_services = map(lambda line: [line.split(" ")[2], line.split(" ")[3], line.split(" ")[11], line.split(" ")[13] if len(line.split(" ")) > 13 and len(line.split(" ")[13]) > 0 else 'FAC003'], update_services_logs)
	caregiver_results = stepsovcdb.query(map_fun)
	for referral in new_referrals:
		caregiver_code = referral[2][:13]
		if caregiver_code in caregiver_map :
			caregiver_map[caregiver_code]["count"] += 1
		else :
			caregiver_map[caregiver_code] = {"count":1,"name":caregiver_results[[caregiver_code]].rows[0].value[0] + " " +caregiver_results[[caregiver_code]].rows[0].value[1] }
	
	map_fun = '''function(doc){ if(doc.type == 'Facility') emit(doc.facilityCode,doc.facilityName) }'''
    facility_results = stepsovcdb.query(map_fun)
	
	for referral in update_services:
		beneficiary_code = referral[2]
		facility_code = referral[3]
		if facility_code in facility_map :
			facility_map[facility_code]["count"] += 1
		else:
			facility_map[facility_code] = {"count":1, "name":facility_results[facility_code].rows[0].value}

	caregiver_with_max_referral = max(caregiver_map.iteritems(), key=operator.itemgetter(1)) if len(caregiver_map) > 0 else None
    facility_with_max_referral = max(facility_map.iteritems(), key=operator.itemgetter(1)) if len(facility_map) > 0 else None
	
	no_of_intimate = len(filter(lambda line: "Due:" in line or "Late:" in line or "Upcoming:" in line, sms_logs))
	no_of_impending = len(filter(lambda line: "will be coming to your facility" in line, sms_logs))
	no_of_defaulted = len(filter(lambda line: "has not fulfilled the referral to" in line, sms_logs))
	no_of_unavailability = len(filter(lambda line: "will be closed from" in line, sms_logs))
	no_of_follow_up = len(filter(lambda line: "due for a visit today" in line, sms_logs))
	total_sms = no_of_intimate+no_of_impending+no_of_defaulted+no_of_follow_up

def sendDailyReport():
	gatherReport(1,'/home/steps-user/apache-tomcat-7.0.22/logs/','http://localhost:5984/')
	report_text = ''
	report_text += '<table border=1><tr bgcolor="#C0C0C0"><th>Key updates for the day</th></tr>'
	report_text += '<tr><td>1. '+str(len(new_referrals))+' new referrals have been made</td></tr>'
	report_text += '<tr><td>2. '+str(len(update_services))+' referrals have been completed</td></tr>'
	report_text += '<tr><td>3. '+str(total_sms)+' SMSs have been sent</td></tr>'
	if caregiver_with_max_referral is not None and len(caregiver_with_max_referral) > 0:
		report_text += '<tr><td>4. '+(caregiver_with_max_referral[1]['name']).title()+' has made maximum referrals</td></tr></table>'
	else:
		report_text += '</table>'
	
	sendMail(['stepsovc_mhealth@googlegroups.com'],'stepsovc mHealth <mhealth@stepsovc.com>','Daily Status Report',report_text)

def sendWeeklyReport():
    gatherReport(7,'/home/steps-user/apache-tomcat-7.0.22/logs/','http://localhost:5984/')
    report_text = ''
    report_text += '<table border=1><tr bgcolor="#C0C0C0"><th colspan="2" align="center">Summary</th></tr>'
	report_text += '<tr><td>Week Starting</td><td align="right">'+ (date.today() - timedelta(7)).isoformat() +'</td></tr>'
    report_text += '<tr><td>Number of referrals created</td><td align="right">'+str(len(new_referrals))+'</td></tr>'
    report_text += '<tr><td>Number of referrals updated</td><td align="right">'+str(len(update_referrals))+'</td></tr>'
    report_text += '<tr><td>Number of referrals completed</td><td align="right">'+str(len(update_services))+'</td></tr>'
	report_text += '<tr><td>Number of messages sent</td><td align="right">'+str(total_sms)+'</td></tr>'
	if caregiver_with_max_referral is not None and len(caregiver_with_max_referral) > 0:
		report_text += '<tr><td>Caregiver who initiated maximum referrals</td><td align="right">'+(caregiver_with_max_referral[1]['name']).title()+'</td></tr>'
	if facility_with_max_referral is not None and len(facility_with_max_referral) > 0:
		report_text += '<tr><td>Healthworker/Facility who updated maximum referrals</td><td align="right">'+facility_with_max_referral[0]+'</td></tr>'
	report_text += '</table><br><br>'
	
	report_text += '<table border=1><tr bgcolor="#C0C0C0"><th colspan="3" align="center"><b>Caregiver Usage<b></th></tr>'
    report_text += '<tr><th align="center">Caregiver Id</td><th align="center">Caregiver Name</th><th align="center">Total Referrals</th></tr>'
	
	for caregiver in caregiver_map:
        report_text += '<tr><td>'+caregiver+'</td><td>'+(caregiver_map[caregiver]["name"]).title()+'</td><td align="center">'+str(caregiver_map[caregiver]["count"])+'</td></tr>'
	
	report_text += '</table><br><br>'
	report_text += '<table border=1><tr bgcolor="#C0C0C0"><th colspan="3" align="center"><b>Healthworker Usage<b></th></tr>'
    report_text += '<tr><th align="center">Facility Id</td><th align="center">Facility Name</th><th align="center">Total Referrals</th></tr>'
	
    for facility in facility_map:
        report_text += '<tr><td>'+facility+'</td><td>'+facility_map[facility]["name"]+'</td><td align="center">'+str(facility_map[facility]["count"])+'</td></tr>'
	
    report_text += '</table><br><br>'
	
	report_text += '<table border=1><tr bgcolor="#C0C0C0"><th colspan="3" align="center"><b>SMS stats<b></th></tr>'
    report_text += '<tr><th align="center">Message Type</td><th align="center">Total</th></tr>'
	
    report_text += '<tr><td>Intimation to facility</td><td align="center">'+str(no_of_intimate)+'</td></tr>'
	report_text += '<tr><td>Alerts on impending referral</td><td align="center">'+str(no_of_impending)+'</td></tr>'
	report_text += '<tr><td>Referral Defaulted</td><td align="center">'+str(no_of_defaulted)+'</td></tr>'
	report_text += '<tr><td>Service Unavailability</td><td align="center">'+str(no_of_unavailability)+'</td></tr>'
	report_text += '<tr><td>Follow Up Reminder</td><td align="center">'+str(no_of_follow_up)+'</td></tr>'
	
    report_text += '</table>'
    sendMail(['stepsovc_mhealth@googlegroups.com'],'stepsovc mHealth <mhealth@stepsovc.com>','Weekly Status Report',report_text)