#!/bin/bash

echo "Wait for the file divert...."

while [ ! -e ./CPDFLAG ]; do
    sleep 1  
done

echo "Welcome to the future..."

if [ ! -d ./rootfs/dev ];then
    mkdir ./rootfs/dev
fi

if [ ! -d ./rootfs/proc ];then
    mkdir ./rootfs/proc
fi

mount -o bind /dev ./rootfs/dev

mount -t proc /proc ./rootfs/proc/

chroot ./rootfs/ sh
