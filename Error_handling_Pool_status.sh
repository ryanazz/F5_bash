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
            echo -e "${RED}wap-pncpadmin-pool-https${NONE}"
	    WPP_MEMBER_NAME=`curl -sk -u $LTM_CREDENTIALS -H "Content-Type: application/json" -X GET https://"$LTM_IP"/"$BASE_LTM_URL"/wap-pncpadmin-pool-hps?expandSubcollections=true |sed 's/,/\n/g' |grep "\"name\":" |awk -F"\"name\":" '{ print $2 }' |perl -ne 'if (m/([a-zA-Z0-9\.-]+:[^\s]+)/) { print "$1\n"}' |sed 's/"//g'`
	    WPP_MEMBER_PRIORITY_GROUP=`curl -sk -u $LTM_CREDENTIALS -H "Content-Type: application/json" -X GET https://"$LTM_IP"/"$BASE_LTM_URL"/wap-pncpadmin-pool-https?expandSubcollections=true |sed 's/,/\n/g' |grep "\"priorityGroup\":" |sed 's/"//g'`
	    WPP_MEMBER_SESSION=` curl -sk -u $LTM_CREDENTIALS -H "Content-Type: application/json" -X GET "https://"$LTM_IP"/$BASE_LTM_URL"/wap-pncpadmin-pool-https?expandSubcollections=true |sed 's/,/\n/g'|grep "\"session\":" |awk -F"\"session\":" '{ print $2 }' |sed 's/"//g'|sed 's/}//g'|sed 's/]//g'`
            WPP_MEMBER_STATUS=` curl -sk -u $LTM_CREDENTIALS -H "Content-Type: application/json" -X GET "https://"$LTM_IP"/$BASE_LTM_URL"/wap-pncpadmin-pool-https?expandSubcollections=true |sed 's/,/\n/g'|grep "\"state\":" |awk -F"\"state\":" '{ print $2 }' |sed 's/"//g'|sed 's/}//g'|sed 's/]//g'`
	    echo -e "${CYAN}MEMBER NAMES:${NONE}"
	    echo -e "$WPP_MEMBER_NAME"
	    echo
	    echo -e "${CYAN}PRIORITY GROUP:${NONE}"
	    echo -e "$WPP_MEMBER_PRIORITY_GROUP"
	    echo
	    echo -e "${CYAN}SESSION STATUS:${NONE}"
	    echo -e "$WPP_MEMBER_SESSION"
	    echo
	    echo -e "${CYAN}MEMBER STATUS:${NONE}"
	    echo -e "$WPP_MEMBER_STATUS"
            ;;
        2)
	    echo
	    echo "=========================================================================================================================================="
            echo -e "${RED}wap-pncpadmin-console-pool-https${NONE}"
            WPCP_MEMBER_NAME=`curl -sk -u $LTM_CREDENTIALS -H "Content-Type: application/json" -X GET https://"$LTM_IP"/"$BASE_LTM_URL"/wap-pncpadmin-console-pool-https?expandSubcollections=true |sed 's/,/\n/g' |grep "\"name\":" |awk -F"\"name\":" '{ print $2 }' |perl -ne 'if (m/([a-zA-Z0-9\.-]+:[^\s]+)/) { print "$1\n"}' |sed 's/"//g'`
	    WPCP_MEMBER_PRIORITY_GROUP=`curl -sk -u $LTM_CREDENTIALS -H "Content-Type: application/json" -X GET https://"$LTM_IP"/"$BASE_LTM_URL"/wap-pncpadmin-console-pool-https?expandSubcollections=true |sed 's/,/\n/g' |grep "\"priorityGroup\":" |sed 's/"//g'`
	    WPCP_MEMBER_SESSION=`curl -sk -u $LTM_CREDENTIALS -H "Content-Type: application/json" -X GET https://"$LTM_IP"/"$BASE_LTM_URL"/wap-pncpadmin-console-pool-https?expandSubcollections=true |sed 's/,/\n/g'|grep "\"session\":" |awk -F"\"session\":" '{ print $2 }' |sed 's/"//g'|sed 's/}//g'|sed 's/]//g'`
            WPCP_MEMBER_STATUS=`curl -sk -u $LTM_CREDENTIALS -H "Content-Type: application/json" -X GET https://"$LTM_IP"/"$BASE_LTM_URL"/wap-pncpadmin-console-pool-https?expandSubcollections=true |sed 's/,/\n/g'|grep "\"state\":" |awk -F"\"state\":" '{ print $2 }' |sed 's/"//g'|sed 's/}//g'|sed 's/]//g'`
	    echo -e "${CYAN}MEMBER NAMES:${NONE}"
            echo -e "$WPCP_MEMBER_NAME"
            echo
            echo -e "${CYAN}PRIORITY GROUP:${NONE}"
            echo -e "$WPCP_MEMBER_PRIORITY_GROUP"
            echo
            echo -e "${CYAN}SESSION STATUS:${NONE}"
            echo -e "$WPCP_MEMBER_SESSION"
            echo
            echo -e "${CYAN}MEMBER STATUS:${NONE}"
            echo -e "$WPCP_MEMBER_STATUS"
            ;;
        3)
            echo
            echo "=========================================================================================================================================="
            echo -e "${RED}wap-pncpadmin-shell-pool-https${NONE}"
	    WPSP_MEMBER_NAME=`curl -sk -u $LTM_CREDENTIALS -H "Content-Type: application/json" -X GET https://"$LTM_IP"/"$BASE_LTM_URL"/wap-pncpadmin-shell-pool-https?expandSubcollections=true |sed 's/,/\n/g' |grep "\"name\":" |awk -F"\"name\":" '{ print $2 }' |perl -ne 'if (m/([a-zA-Z0-9\.-]+:[^\s]+)/) { print "$1\n"}' |sed 's/"//g'`
	    WPSP_MEMBER_PRIORITY_GROUP=` curl -sk -u $LTM_CREDENTIALS -H "Content-Type: application/json" -X GET https://"$LTM_IP"/"$BASE_LTM_URL"/wap-pncpadmin-shell-pool-https?expandSubcollections=true |sed 's/,/\n/g' |grep "\"priorityGroup\":" |sed 's/"//g'`
	    WPSP_MEMBER_SESSION=`curl -sk -u $LTM_CREDENTIALS -H "Content-Type: application/json" -X GET https://"$LTM_IP"/"$BASE_LTM_URL"/wap-pncpadmin-shell-pool-https?expandSubcollections=true |sed 's/,/\n/g'|grep "\"session\":" |awk -F"\"session\":" '{ print $2 }' |sed 's/"//g'|sed 's/}//g'|sed 's/]//g'`
	    WPSP_MEMBER_STATUS=`curl -sk -u $LTM_CREDENTIALS -H "Content-Type: application/json" -X GET https://"$LTM_IP"/"$BASE_LTM_URL"/wap-pncpadmin-shell-pool-https?expandSubcollections=true |sed 's/,/\n/g'|grep "\"state\":" |awk -F"\"state\":" '{ print $2 }' |sed 's/"//g'|sed 's/}//g'|sed 's/]//g'`
	    echo -e "${CYAN}MEMBER NAMES:${NONE}"
            echo -e "$WPSP_MEMBER_NAME"
            echo
            echo -e "${CYAN}PRIORITY GROUP:${NONE}"
            echo -e "$WPSP_MEMBER_PRIORITY_GROUP"
            echo
            echo -e "${CYAN}SESSION STATUS:${NONE}"
            echo -e "$WPSP_MEMBER_SESSION"
            echo
            echo -e "${CYAN}MEMBER STATUS:${NONE}"
            echo -e "$WPSP_MEMBER_STATUS"
            ;;
    esac
done
