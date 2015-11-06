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

Server=tcfabric-pncp-01.mla1.dev.sc.local
Port=443

LTM_IP=10.239.36.153
BASE_LTM_URL=mgmt/tm/ltm/pool
LTM_CREDENTIALS=admin:admin


#cmd=(dialog --separate-output --checklist "Select options:" 22 76 6)
cmd=(dialog --separate-output --checklist "TCFABRIC-PNCPP-01.MLA1.DEV.SC.LOCAL" 18 76 16)
options=(1 "wap-pncpadmin-pool-https -- ENABLE" off    # any option can be set to default to "on"
         2 "wap-pncpadmin-console-pool-https -- ENABLE" off
         3 "wap-pncpadmin-shell-pool-https  -- ENABLE" off
	 4 "wap-pncpadmin-pool-https -- DISABLE" off
	 5 "wap-pncpadmin-console-pool-https -- DISABLE" off
	 6 "wap-pncpadmin-shell-pool-https  -- DISABLE" off)
choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
clear
for choice in $choices
do
    case $choice in
        1)
	    echo -e "${GREEN}Enabling tcfabric-pncp-01.mla1.dev.sc.local in wap-pncpadmin-pool-https Pool${NONE}"
            curl -sk -u $LTM_CREDENTIALS  https://"$LTM_IP"/"$BASE_LTM_URL"/wap-pncpadmin-pool-https/members/~Common~"$Server":"$Port"/ -H "Content-Type: application/json" -X PUT -d '{"session": "user-enabled"}'
	    echo -e "\n${GREEN}tcfabric-pncp-01.mla1.dev.sc.local enabled on wap-pncpadmin-pool-https Pool${NONE}"
            ;;
        2)
	    echo -e "${GREEN}Enabling tcfabric-pncp-01.mla1.dev.sc.local in wap-pncpadmin-console-pool-https Pool${NONE}"
	    curl -sk -u $LTM_CREDENTIALS https://"$LTM_IP"/"$BASE_LTM_URL"/wap-pncpadmin-console-pool-https/members/~Common~"$Server":"$Port"/ -H "Content-Type: application/json" -X PUT -d '{"session": "user-enabled"}'
	    echo -e "\n${GREEN}tcfabric-pncp-01.mla1.dev.sc.local enabled on wap-pncpadmin-console-pool-https Pool${NONE}"
            ;;
        3)
	     echo -e "${GREEN}Enabling tcfabric-pncp-01.mla1.dev.sc.local in wap-pncpadmin-shell-pool-https Pool${NONE}"
	     curl -sk -u $LTM_CREDENTIALS https://"$LTM_IP"/"$BASE_LTM_URL"/wap-pncpadmin-shell-pool-https/members/~Common~"$Server":"$Port"/ -H "Content-Type: application/json" -X PUT -d '{"session": "user-enabled"}'
            echo -e "\n${GREEN}tcfabric-pncp-01.mla1.dev.sc.local enabled on wap-pncpadmin-shell-pool-https Pool${NONE}"
            ;;
	4)
	     echo -e "${RED}Disabling tcfabric-pncp-01.mla1.dev.sc.local from wap-pncpadmin-pool-https Pool${NONE}"
	     curl -sk -u $LTM_CREDENTIALS https://"$LTM_IP"/"$BASE_LTM_URL"/wap-pncpadmin-pool-https/members/~Common~"$Server":"$Port"/ -H "Content-Type: application/json" -X PUT -d '{"session": "user-disabled"}'
	     echo -e "\n${RED}tcfabric-pncp-01.mla1.dev.sc.local disabled from wap-pncpadmin-pool-https Pool${NONE}"
	    ;;
	5)
             echo -e "${RED}Disabling tcfabric-pncp-01.mla1.dev.sc.local from wap-pncpadmin-console-pool-https Pool${NONE}"
	     curl -sk -u $LTM_CREDENTIALS https://"$LTM_IP"/"$BASE_LTM_URL"/wap-pncpadmin-console-pool-https/members/~Common~"$Server":"$Port"/ -H "Content-Type: application/json" -X PUT -d '{"session": "user-disabled"}'
             echo -e "\n${RED}tcfabric-pncp-01.mla1.dev.sc.local disabled from wap-pncpadmin-console-pool-https Pool${NONE}"
            ;;
	6)
             echo -e "${RED}Disabling tcfabric-pncp-01.mla1.dev.sc.local from wap-pncpadmin-shell-pool-https${NONE}"
             curl -sk -u $LTM_CREDENTIALS https://"$LTM_IP"/"$BASE_LTM_URL"/wap-pncpadmin-shell-pool-https/members/~Common~"$Server":"$Port"/ -H "Content-Type: application/json" -X PUT -d '{"session": "user-disabled"}'
             echo -e "\n${RED}tcfabric-pncp-01.mla1.dev.sc.local disabled from wap-pncpadmin-shell-pool-https${NONE}"
            ;;




    esac
done
