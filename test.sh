#!/bin/bash

export NCURSES_NO_UTF8_ACS=1
NONE='\033[00m'
RED='\033[01;31m'
GREEN='\033[01;32m'
YELLOW='\033[01;33m'
PURPLE='\033[01;35m'
CYAN='\033[01;36m'
WHITE='\033[01;37m'
BOLD='\033[1m'
UNDERLINE='\033[4m'


LTM_IP=10.239.36.153
BASE_LTM_URL=mgmt/tm/ltm/pool
LTM_CREDENTIALS=admin:admin



cmd=(dialog --separate-output --checklist "Select options:" 18 56 6)
options=(1 "wap-pncpadmin-pool-https" off    # any option can be set to default to "on"
         2 "wap-pncpadmin-console-pool-https" off
         3 "wap-pncpadmin-shell-pool-https" off)
choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
clear
for choice in $choices
do
    case $choice in
        1)

            CHECK=`curl -sk --head -u $LTM_CREDENTIALS -H "Content-Type: application/json" -X GET https://"$LTM_IP"/"$BASE_LTM_URL"/wap-pncpadmin-pool-hts?expandSubcollections=true | head -n 1 | grep -c "HTTP/1.1 200 OK"`
            if [ $CHECK -eq 1 ]
            then
            echo -e "${RED}wap-pncpadmin-pool-https${NONE}"
	    WPP_MEMBER_NAME=`curl -sk -u $LTM_CREDENTIALS -H "Content-Type: application/json" -X GET https://"$LTM_IP"/"$BASE_LTM_URL"/wap-pncpadmin-pool-https?expandSubcollections=true |sed 's/,/\n/g' |grep "\"name\":" |awk -F"\"name\":" '{ print $2 }' |perl -ne 'if (m/([a-zA-Z0-9\.-]+:[^\s]+)/) { print "$1\n"}' |sed 's/"//g'`
	    echo -e "$WPP_MEMBER_NAME"
            exit 0
            else 
	    echo "POOL NOT AVAILABLE - something went wrong!!"
            exit 1
            fi
            ;;
    esac
done
