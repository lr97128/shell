#! /bin/bash
/srccode/sendSyslog.py warning && /srccode/testrsyslog.sh >> /var/log/checkrsyslog.log
