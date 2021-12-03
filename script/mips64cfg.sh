#!/usr/bin/expect


set structure [lindex $argv 0]
set RUNTIME_BOARDB [lindex $argv 1]
set RUNTIME_KERNEL [lindex $argv 2]
set RUNTIME_FQCOW2 [lindex $argv 3]
set RUNTIME_COMAND [lindex $argv 4]

set timeout -1

spawn qemu-system-mips64 -M $RUNTIME_BOARDB -kernel ./$structure/$RUNTIME_KERNEL -hda ./$structure/$RUNTIME_FQCOW2 -append "root=/dev/sda1 console=tty0" -net nic -net tap,ifname=tap0,script=no,downscript=no -nographic -s

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

