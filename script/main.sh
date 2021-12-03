#!/usr/bin/sudo bash

# armel online resource 
armel_squeeze_qcow2="https://people.debian.org/~aurel32/qemu/armel/debian_squeeze_armel_standard.qcow2"
armel_initrd_2_6="https://people.debian.org/~aurel32/qemu/armel/initrd.img-2.6.32-5-versatile"
armel_kernel_2_6="https://people.debian.org/~aurel32/qemu/armel/vmlinuz-2.6.32-5-versatile"
armel_wheezy_qcow2="https://people.debian.org/~aurel32/qemu/armel/debian_wheezy_armel_standard.qcow2"
armel_initrd_3_2="https://people.debian.org/~aurel32/qemu/armel/initrd.img-3.2.0-4-versatile"
armel_kernel_3_2="https://people.debian.org/~aurel32/qemu/armel/vmlinuz-3.2.0-4-versatile"

# armhf online resource
armhf_wheezy_qcow2="https://people.debian.org/~aurel32/qemu/armhf/debian_wheezy_armhf_standard.qcow2"
armhf_initrd_3_2="https://people.debian.org/~aurel32/qemu/armhf/initrd.img-3.2.0-4-vexpress"
armhf_kernel_3_2="https://people.debian.org/~aurel32/qemu/armhf/vmlinuz-3.2.0-4-vexpress"

# mips online resource 
mips_squeeze_qcow2="https://people.debian.org/~aurel32/qemu/mips/debian_squeeze_mips_standard.qcow2"
mips_wheezy_qcow2="https://people.debian.org/~aurel32/qemu/mips/debian_wheezy_mips_standard.qcow2"
mips_kernel_2_6_4kc="https://people.debian.org/~aurel32/qemu/mips/vmlinux-2.6.32-5-4kc-malta"
mips_kernel_2_6_5kc="https://people.debian.org/~aurel32/qemu/mips/vmlinux-2.6.32-5-5kc-malta"
mips_kernel_3_2_4kc="https://people.debian.org/~aurel32/qemu/mips/vmlinux-3.2.0-4-4kc-malta"
mips_kernel_3_2_5kc="https://people.debian.org/~aurel32/qemu/mips/vmlinux-3.2.0-4-5kc-malta"

# mipsel online resource
mipsel_squeeze_qcow2="https://people.debian.org/~aurel32/qemu/mipsel/debian_squeeze_mipsel_standard.qcow2"
mipsel_wheezy_qcow2="https://people.debian.org/~aurel32/qemu/mipsel/debian_wheezy_mipsel_standard.qcow2"
mipsel_kernel_2_6_4kc="https://people.debian.org/~aurel32/qemu/mipsel/vmlinux-2.6.32-5-4kc-malta"
mipsel_kernel_2_6_5kc="https://people.debian.org/~aurel32/qemu/mipsel/vmlinux-2.6.32-5-5kc-malta"
mipsel_kernel_3_2_4kc="https://people.debian.org/~aurel32/qemu/mipsel/vmlinux-3.2.0-4-4kc-malta"
mipsel_kernel_3_2_5kc="https://people.debian.org/~aurel32/qemu/mipsel/vmlinux-3.2.0-4-5kc-malta"

RUNTIME_FQCOW2=""
RUNTIME_KERNEL=""
RUNTIME_INITRD=""
RUNTIME_BOARDB=""
RUNTIME_COMAND=""

function help(){
  echo "Usage: qemustart.sh structure[armel|armhf|mipsel|mips] version[squeeze|wheezy] bit[32|64]"
  echo "For example: qemustart.sh armel squeeze"
  echo "For example: qemustart.sh armel wheezy"
  echo "For example: qemustart.sh armhf wheezy"
  echo "For example: qemustart.sh mips squeeze 32"
  echo "For example: qemustart.sh mips squeeze 64"
  echo "For example: qemustart.sh mips wheezy 32"
  echo "For example: qemustart.sh mips wheezy 64"
  echo "For example: qemustart.sh mipsel squeeze 32"
  echo "For example: qemustart.sh mipsel squeeze 64"
  echo "For example: qemustart.sh mipsel wheezy 32"
  echo "For example: qemustart.sh mipsel wheezy 64"
}

structure=$1
version=$2
bit=$3

case $structure in
    "armel")  
              if [[ "$version" == "squeeze" ]]
              then
                RUNTIME_COMAND="qemu-system-arm"
                RUNTIME_KERNEL=$armel_kernel_2_6
                RUNTIME_INITRD=$armel_initrd_2_6
                RUNTIME_FQCOW2=$armel_squeeze_qcow2
                RUNTIME_BOARDB="versatilepb"
              elif [[ "$version" == "wheezy" ]]
              then
                RUNTIME_COMAND="qemu-system-arm"
                RUNTIME_KERNEL=$armel_kernel_3_2
                RUNTIME_INITRD=$armel_initrd_3_2
                RUNTIME_FQCOW2=$armel_wheezy_qcow2
                RUNTIME_BOARDB="versatilepb"
              else
                help;
                exit;
              fi
    ;;
    "armhf")  
                RUNTIME_COMAND="qemu-system-arm"
                RUNTIME_KERNEL=$armhf_kernel_3_2
                RUNTIME_INITRD=$armhf_initrd_3_2
                RUNTIME_FQCOW2=$armhf_wheezy_qcow2
                RUNTIME_BOARDB="vexpress-a9"
    ;;
    "mips")
              if [[ "$version" == "squeeze" ]]
              then
                if [[ "$bit" == "32" ]]
                then
                  RUNTIME_COMAND="qemu-system-mips"
                  RUNTIME_KERNEL=$mips_kernel_2_6_4kc
                  RUNTIME_FQCOW2=$mips_squeeze_qcow2
                  RUNTIME_BOARDB="malta"
                elif [[ "$bit" == "64" ]]
                then
                  RUNTIME_COMAND="qemu-system-mips64"
                  RUNTIME_KERNEL=$mips_kernel_2_6_5kc
                  RUNTIME_FQCOW2=$mips_squeeze_qcow2
                  RUNTIME_BOARDB="malta"
                else
                  help;
                  exit;
                fi
              elif [[ "$version" == "wheezy" ]]
              then
                if [[ "$bit" == "32" ]]
                then
                  RUNTIME_COMAND="qemu-system-mips"
                  RUNTIME_KERNEL=$mips_kernel_3_2_4kc
                  RUNTIME_FQCOW2=$mips_wheezy_qcow2
                  RUNTIME_BOARDB="malta"
                elif [[ "$bit" == "64" ]]
                then
                  RUNTIME_COMAND="qemu-system-mips64"
                  RUNTIME_KERNEL=$mips_kernel_3_2_5kc
                  RUNTIME_FQCOW2=$mips_wheezy_qcow2
                  RUNTIME_BOARDB="malta"
                else
                  help;
                  exit;
                fi
              else
                help;
                exit;
              fi
    ;;
    "mipsel")
              if [[ "$version" == "squeeze" ]]
              then
                if [[ "$bit" == "32" ]]
                then
                  RUNTIME_COMAND="qemu-system-mipsel"
                  RUNTIME_KERNEL=$mipsel_kernel_2_6_4kc
                  RUNTIME_FQCOW2=$mipsel_squeeze_qcow2
                  RUNTIME_BOARDB="malta"
                elif [[ "$bit" == "64" ]]
                then
                  RUNTIME_COMAND="qemu-system-mips64el"
                  RUNTIME_KERNEL=$mipsel_kernel_2_6_5kc
                  RUNTIME_FQCOW2=$mipsel_squeeze_qcow2
                  RUNTIME_BOARDB="malta"
                else
                  help;
                  exit;
                fi
              elif [[ "$version" == "wheezy" ]]
              then
                if [[ "$bit" == "32" ]]
                then
                  RUNTIME_COMAND="qemu-system-mipsel"
                  RUNTIME_KERNEL=$mipsel_kernel_3_2_4kc
                  RUNTIME_FQCOW2=$mipsel_wheezy_qcow2
                  RUNTIME_BOARDB="malta"
                elif [[ "$bit" == "64" ]]
                then
                  RUNTIME_COMAND="qemu-system-mips64el"
                  RUNTIME_KERNEL=$mipsel_kernel_3_2_5kc
                  RUNTIME_FQCOW2=$mipsel_wheezy_qcow2
                  RUNTIME_BOARDB="malta"
                else
                  help;
                  exit;
                fi
              else
                help;
                exit;
              fi
    ;;
    *)  help;
        exit;
    ;;
esac


if [ ! -d "./$structure" ]; then
  mkdir ./$structure
fi

echo "[*]Check kernel file ..."
if [[ $RUNTIME_KERNEL != '' ]]; then
  if [ ! -f "./$structure/${RUNTIME_KERNEL##*/}" ]; then
    wget -P "./$structure/" -q --show-progress  $RUNTIME_KERNEL --no-check-certificate
  fi
fi
RUNTIME_KERNEL=${RUNTIME_KERNEL##*/}
echo "[+]Done ..."
echo "[*]Check initrd file ..."
if [[ $RUNTIME_INITRD != '' ]]; then
  if [ ! -f "./$structure/${RUNTIME_INITRD##*/}" ]; then
    wget -P "./$structure/" -q --show-progress  $RUNTIME_INITRD --no-check-certificate
  fi
else
  echo "[x]Don't need an initrd file!"
fi
RUNTIME_INITRD=${RUNTIME_INITRD##*/}
echo "[+]Done ..."
echo "[*]Check QCOW2 file ..."
if [[ $RUNTIME_FQCOW2 != '' ]]; then
  if [ ! -f "./$structure/${RUNTIME_FQCOW2##*/}" ]; then
    wget -P "./$structure/" -q --show-progress  $RUNTIME_FQCOW2 --no-check-certificate
  fi
fi
RUNTIME_FQCOW2=${RUNTIME_FQCOW2##*/}
echo "[*]Done ..."


echo "[+]Configure the network"
tunctl -t tap0 -u root
echo "[+]Configure the tap0 address to 192.168.3.1"
ifconfig tap0 192.168.3.1/24
echo "[*]Network Configure success"


echo "[+]Create a new temp file"
rsync -ah --progress "./$structure/$RUNTIME_FQCOW2" "./$structure/temp_standard.qcow2"
RUNTIME_FQCOW2="temp_standard.qcow2"
echo "[*]temp file setting done"

gnome-terminal -x ./script/cpf2vm.sh

case $structure in
    "armel")
        gnome-terminal -x ./script/armelcfg.sh $structure $RUNTIME_BOARDB $RUNTIME_KERNEL $RUNTIME_INITRD $RUNTIME_FQCOW2 $RUNTIME_COMAND                  
    ;;
    "armhf")
        gnome-terminal -x ./script/armhfcfg.sh $structure $RUNTIME_BOARDB $RUNTIME_KERNEL $RUNTIME_INITRD $RUNTIME_FQCOW2 $RUNTIME_COMAND
    ;;
    "mips")
        if [[ "$bit" == "32" ]]
        then
          gnome-terminal -x ./script/mipscfg.sh $structure $RUNTIME_BOARDB $RUNTIME_KERNEL $RUNTIME_FQCOW2 $RUNTIME_COMAND
        elif [[ "$bit" == "64" ]]
        then
          gnome-terminal -x ./script/mips64cfg.sh $structure $RUNTIME_BOARDB $RUNTIME_KERNEL $RUNTIME_FQCOW2 $RUNTIME_COMAND
        else
          help;
          exit;
        fi
    ;;
    "mipsel")
        if [[ "$bit" == "32" ]]
        then
          gnome-terminal -x ./script/mipselcfg.sh $structure $RUNTIME_BOARDB $RUNTIME_KERNEL $RUNTIME_FQCOW2 $RUNTIME_COMAND
        elif [[ "$bit" == "64" ]]
        then
          gnome-terminal -x ./script/mips64elcfg.sh $structure $RUNTIME_BOARDB $RUNTIME_KERNEL $RUNTIME_FQCOW2 $RUNTIME_COMAND
        else
          help;
          exit;
        fi
    ;;
    *)  help;
        exit;
esac
