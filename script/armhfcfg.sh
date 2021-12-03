#!/usr/bin/expect


set structure [lindex $argv 0]
set RUNTIME_BOARDB [lindex $argv 1]
set RUNTIME_KERNEL [lindex $argv 2]
set RUNTIME_INITRD [lindex $argv 3]
set RUNTIME_FQCOW2 [lindex $argv 4]
set RUNTIME_COMAND [lindex $argv 5]

set timeout -1

spawn qemu-system-arm -M $RUNTIME_BOARDB -kernel ./$structure/$RUNTIME_KERNEL -initrd ./$structure/$RUNTIME_INITRD -drive if=sd,file=./$structure/$RUNTIME_FQCOW2 -append root=/dev/mmcblk0p2 -net nic -net tap,ifname=tap0,script=no,downscript=no -nographic

expect {
  login { send "root\n"}
}
expect {
  Password { send "root\n"}
}
expect {
  root@ { send "ifconfig eth0 192.168.3.2/24\n"}
}
expect {
  root@ { send "sleep 3\n"}
}
expect {
  root@ { send "./ch2vm.sh\n"}
}

interact

