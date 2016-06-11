#!/bin/bash

#
# create rootfs folder
#
mkdir rootfs

#
# PS: /dev/sda device must be ext4 format!
#
mount /dev/sdb1 rootfs
cd rootfs
rm -rf ./*

#
# untar ubuntu core rootfs
# http://cdimage.ubuntu.com/ubuntu-base/releases/16.04/release/
#
tar xf ../ubuntu-base-16.04-core-amd64.tar.gz

#
# set up hostname, hosts, eth0 (enp0s3 now), and fstab
#
echo "wisnuc"                        > etc/hostname
echo "127.0.0.1 localhost"           > etc/hosts
echo "127.0.1.1 wisnuc"              > etc/hosts
echo "[Match]"                       > etc/systemd/network/wired.network
echo "Name=en*"                     >> etc/systemd/network/wired.network
echo "[Network]"                    >> etc/systemd/network/wired.network
echo "DHCP=ipv4"                    >> etc/systemd/network/wired.network
echo "/dev/sdb1 / ext4 defaults 1 1" > etc/fstab

#
# enable universe and multiverse
#
echo "deb http://archive.ubuntu.com/ubuntu/ xenial main restricted" > etc/apt/sources.list
echo "deb http://archive.ubuntu.com/ubuntu/ xenial-updates main restricted" >> etc/apt/sources.list
echo "deb http://archive.ubuntu.com/ubuntu/ xenial universe" >> etc/apt/sources.list
echo "deb http://archive.ubuntu.com/ubuntu/ xenial-updates universe" >> etc/apt/sources.list
echo "deb http://archive.ubuntu.com/ubuntu/ xenial-backports main restricted" >> etc/apt/sources.list
echo "deb http://archive.ubuntu.com/ubuntu/ xenial-security main restricted" >> etc/apt/sources.list
echo "deb http://archive.ubuntu.com/ubuntu/ xenial-security universe" >> etc/apt/sources.list
echo "deb http://archive.ubuntu.com/ubuntu/ xenial-security multiverse" >> etc/apt/sources.list

#
# put a temporary DNS, important!
#
echo "nameserver 208.67.222.222"   > etc/resolv.conf

mount -t devtmpfs none dev
mount -t proc none proc
mount -t sysfs none sys

chroot . apt-get update
chroot . apt-get -y install linux-{headers,image}-generic net-tools iproute2 iputils-ping sudo nano tree curl wget openssh-server

chroot . grub-install /dev/sdb
chroot . chmod a-x /etc/grub.d/30_os-prober
chroot . update-grub
chroot . update-grub2

#
# set root passwd
#
chroot . bash -c 'echo "root:123456" | chpasswd'

#
# add admin 
#
chroot . adduser --uid 1000 --gecos ",,," --disabled-password --home /home/admin --shell /bin/bash admin
chroot . bash -c 'echo "admin:123456" | chpasswd'

# chroot . adduser admin
chroot . addgroup admin adm
chroot . addgroup admin sudo

chroot . systemctl enable systemd-networkd
chroot . systemctl enable systemd-resolved

# according to Arch doc
chroot . rm -rf /etc/resolv.conf
chroot . ln -s /run/systemd/resolve/resolv.conf /etc/resolv.conf

umount sys 
umount proc
umount dev

cd ..
umount rootfs
