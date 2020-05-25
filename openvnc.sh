#!/bin/bash
lingzhou(){
	systemctl restart iptables && iptables -t filter -I INPUT 11 -p tcp -m state --state NEW --dport 5907 -j ACCEPT && iptables -t filter -I INPUT 11 -p tcp -m state --state NEW --dport 5907 -j LOG --log-prefix lingzhou --log-level 5 --log-tcp-sequence --log-ip-options && echo "lingzhou vnc 已经启动了，可以远程登录了"
}
cisco(){
	systemctl restart iptables &&  iptables -t filter -I INPUT 11 -p tcp -m state --state NEW --dport 5910 -j ACCEPT && iptables -t filter -I INPUT 11 -p tcp -m state --state NEW --dport 5910 -j LOG --log-prefix cisco --log-level 5 --log-tcp-sequence --log-ip-options && echo "cisco vnc 已经启动了，可以远程登录了"
}
close(){
	systemctl restart iptables && echo "vnc已经关闭，拒绝lingzhou和cisco远程登录"
}
case "$1" in
	lingzhou)
		lingzhou
		;;
	cisco)
		cisco
		;;
	close)
		close
		;;
esac
exit 0
