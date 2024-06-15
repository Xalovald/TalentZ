#!/bin/bash

PASSWORD=$1

echo "Copying files with sudo"

/usr/bin/expect << EOF
spawn sudo rsync -av --delete . /root/TalentZ
expect "ass"
send "$PASSWORD\n"
expect eof
EOF
