#!/usr/bin/env bash

# /*
# * Copyright (C) 2024 Shoiya Akari. All rights reserved. (barryofc11@gmail.com)
# *
# * This script is based on the original script by xiliuya (https://github.com/xiliuya).
# * Licensed under the MIT License.
# *
# * Title: LXC Container Setup and Creation
# * Description: This script configures and creates LXC containers on Termux.
# * It allows the user to select the system architecture and Linux distribution,
# * downloads and sets up the container image, and adjusts network settings and
# * the root password as specified.
# */

arch=""
lxc_command="lxc"
container_name=""
root_password_hash="root:\$6\$xN6M9kkuCkpj9S9p\$wJAz/T3f2toirqBg9o7M5xrPRbuQvMNbarBCCrV9DQWZLEc3xB23N35qrJ.jk0nZrGdta/q9mCc1UqRpe6xwb.:19960:0:99999:7:::"

if [ ! -d ~/storage ] && [ -x "termux-setup-storage" ]; then
    termux-setup-storage
fi
if [ -x "$(command -v apt)" ]; then
    if [ ! -x "$(command -v lxc)" ] || [ ! -x "$(command -v wget)" ] || [ ! -x "$(command -v tar)" ]; then
        apt update && apt upgrade -y &&
        apt install -y lxc tar wget
    fi
fi

case $(uname -m) in
aarch64)
    arch="arm64"
    ;;
arm)
    arch="armhf"
    ;;
amd64)
    arch="amd64"
    ;;
x86_64)
    arch="amd64"
    ;;
*)
    echo "System architecture not supported"
    exit 1
    ;;
esac

echo "********************************"
echo "   Select the system architecture   "
echo "   aarch64  Enter: 1"
echo "   armhf  Enter: 2"
echo "   x86   Enter: 3"
echo "   amd64  Enter: 4"
echo "   Others Enter the architecture name"
echo "   (Will use the system architecture by default)"
echo "********************************"
echo ""
read -p "Enter: " charch
case $charch in
"1")
    newarch="arm64"
    ;;
"2")
    newarch="armhf"
    ;;
"3")
    newarch="i386"
    ;;
"4")
    newarch="amd64"
    ;;
"")
    newarch=$arch
    ;;
*)
    newarch=$charch
    ;;
esac

echo "********************************"
echo "   Select the Linux distribution   "
echo "   debian  Enter: 1"
echo "   ubuntu  Enter: 2"
echo "   kali   Enter: 3"
echo "   fedora  Enter: 4"
echo "   Others Enter the distribution name"
echo "   (E.g., archlinux, alpine, centos...)"
echo "********************************"
echo ""
read -p "Enter: " name
case $name in
"1")
    linux="debian"
    ;;
"2")
    linux="ubuntu"
    ;;
"3")
    linux="kali"
    linux_ver="current"
    ;;
"4")
    linux="fedora"
    ;;
*)
    linux=$name
    read -p "Enter the system version: " banben
    linux_ver=$banben
    ;;
esac

case $linux in
"debian")
    release="bullseye"
    ;;
"ubuntu")
    release="focal"
    ;;
"fedora")
    release="34"
    ;;
*)
    release=$linux_ver
    ;;
esac

container_name="${linux}_${newarch}"
echo "Creating the container with the name $container_name..."

sudo lxc-create -t download -n "$container_name" -- --no-validate -d "$linux" -r "$release" -a "$newarch"

echo "LXC setup completed. You can now start a container with the command:"
echo "lxc-start -n $container_name -d -F"

echo "Configuring network for the container..."
container_rootfs="/data/data/com.termux/files/usr/var/lib/lxc/$container_name/rootfs"

if [ -d "$container_rootfs" ]; then
    echo "Updating DNS"
    echo "127.0.0.1 localhost" >"$container_rootfs/etc/hosts"
    rm -rf "$container_rootfs/etc/resolv.conf"
    echo "nameserver 114.114.114.114" >"$container_rootfs/etc/resolv.conf"
    echo "nameserver 8.8.4.4" >>"$container_rootfs/etc/resolv.conf"

    echo "export TZ='America/Sao_Paulo'" >>"$container_rootfs/root/.bashrc"

    shadow_file="$container_rootfs/etc/shadow"
    if [ -f "$shadow_file" ]; then
        echo "Configuring root password..."
        sed -i "s|^root:.*|$root_password_hash|" "$shadow_file"
        echo "Root password configured."
    else
        echo "File /etc/shadow not found. Please check if the container was created correctly!"
        exit 1
    fi

    echo "Network configuration completed."
else
    echo "Rootfs directory not found. Please check if the container was created correctly."
    exit 1
fi

read -p "Do you want to start the container now? (y/n): " start_cont
if [ "$start_cont" = "y" ]; then
    echo "Starting container $container_name"
    sudo lxc-start -n "$container_name" -d -F
fi
