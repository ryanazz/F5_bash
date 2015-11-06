#!/bin/bash

HOME=/root/ryan/scripts

f_check_pool_members () {
	$HOME/Pool_status.sh
	exit
}

f_manage_tcfabric01 () {
	$HOME/Manage_Tcfabric-01.sh
	exit
}

f_manage_tcfabric02 () {
        $HOME/Manage_Tcfabric-02.sh
        exit
}

f_manage_tcfabric03 () {
        $HOME/Manage_Tcfabric-03.sh
        exit
}



while : # Loop forever
do
/bin/cat << !

LTM Main Menu :: Select Option

1. Manage TCFABRIC-PNCP-01.MLA1.DEV.SC.LOCAL
2. Manage TCFABRIC-PNCP-02.MLA1.DEV.SC.LOCAL
3. Manage TCFABRIC-PNCP-03.MLA1.DEV.SC.LOCAL
4. Check Pool Members & Status
5. Quit

!

echo -n " Your choice? : "
read choice

case $choice in
1) f_manage_tcfabric01
	;;
2) f_manage_tcfabric02
	;;
3) f_manage_tcfabric03
	;;
4) f_check_pool_members
        ;;
5) exit
	;;
*) echo "\"$choice\" is not valid "; sleep 2 ;;
esac
done
