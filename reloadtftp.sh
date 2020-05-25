#!/usr/bin/expect
set timeout 20
set IP [lindex $argv 0]
spawn ssh root@${IP}
expect "d:"
send "WhcatvManage@2014\r"
expect "#"
send "/opt/nwreg2/local/usrbin/nrcmd\r"
expect "username:"
send "admin\r"
expect "password:"
send "VPN10012\r"
expect "nrcmd>"
send "tftp reload\r"
send "exit\r"
expect eof
