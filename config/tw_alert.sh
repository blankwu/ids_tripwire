#!/bin/sh
#

PASSPHRASE="passphrase"
SMTP_HOST="smtp.localhost.com"
EMAIL_USER="localhost@localhost.com"
EMAIL_PASSWORD="password"
RECIVE_USER="alert@localhost.com"
#
HOST_NAME=`hostname`
#
echo "set from=$EMAIL_USER" >> /etc/s-nail.rc
echo "set smtp=smtps://${SMTP_HOST}:465" >> /etc/s-nail.rc
echo "set smtp-auth-user=${EMAIL_USER}" >> /etc/s-nail.rc
echo "set smtp-auth-password=${EMAIL_PASSWORD}" >> /etc/s-nail.rc
echo "set smtp-auth=login" >> /etc/s-nail.rc
#
echo $PASSPHRASE | twadmin --generate-keys -S /etc/tripwire/site.key
echo $PASSPHRASE | twadmin --generate-keys -L /etc/tripwire/local.key
echo $PASSPHRASE | twadmin --create-cfgfile -S /etc/tripwire/site.key /etc/tripwire/twcfg.txt
echo $PASSPHRASE | twadmin --create-polfile -S /etc/tripwire/site.key /etc/tripwire/twpol.txt
#
tripwire --init
#
while true
do
	cd /tmp
	tripwire --check > new.report
	check_error=`grep -c 'error' new.report`
	if [ ${check_error} -ne 0 ]
	then
		echo -e "\033[31m `date` - error notification \n \033[0m"
		mail -s "$HOST_NAME" $RECIVE_USER < new.report
                sleep_time=3600
	else
		check_violations=`grep "violations" new.report | awk '{print $4}'`
		if [ $check_violations -ne 0 ]
		then
			echo "\033[31m `date` - Security notification \n \033[0m"
			mail -s "IDS Alert : $HOST_NAME" $RECIVE_USER < new.report
                        sleep_time=3600
		else
			echo "\033[32m `date` - no Security Risk \n \033[0m"
                        sleep_time=60
		fi
	fi
	sleep $sleep_time
done
