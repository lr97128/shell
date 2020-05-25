#!/usr/bin/expect
set timeout 20
set OPT [lindex $argv 0]
set MYIP [lindex $argv 1]
spawn ssh liurui@10.33.33.46 -p 22220
expect "password:"
send "Lr@824393\r"
expect "$ "
send "LANG=en_US.UTF-8\r"
expect "$ "
send "su -\r"
expect "word:"
send "liurui97128224\r"
expect "#"
send "/opt/remote-control $OPT $MYIP\r"
expect eof
