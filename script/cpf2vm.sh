#!/bin/bash
count=0
while :
do
    ((count++))
    dot=''
    for ((i=0;i<$count%4;i++))
    do
      dot=".$dot"
    done
    echo -e "Wait for virtual machine $dot \r\c"
    ping -c 1 192.168.3.2 >/dev/null 2>&1
    if [[ $? == 0 ]];then
      break
    fi
done

ssh-keygen -R 192.168.3.2

scp_autoch()
{
/usr/bin/expect<<-EOF
set timeout 30
spawn scp ./script/ch2vm.sh root@192.168.3.2:/root/
expect {
  (yes/no) { send "yes\n"}
}
expect {
  password { send "root\n"}
}
expect eof
EOF
}


scp_rootfs()
{
/usr/bin/expect<<-EOF
set timeout 300
spawn scp -r ./rootfs root@192.168.3.2:/root/
expect {
  password { send "root\n"}
}
expect eof
EOF
}

scp_cpdflag()
{
/usr/bin/expect<<-EOF
set timeout 300
spawn scp -r ./script/CPDFLAG root@192.168.3.2:/root/
expect {
  password { send "root\n"}
}
expect eof
EOF
}


scp_autoch

scp_rootfs

scp_cpdflag

echo "Transfer File Finished"
echo "quiting..."
sleep 5


