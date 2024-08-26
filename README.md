# Termux-Linux
**English** | [概述](README_CN.md)

## Overview
This script allows you to run various Linux distributions on Termux using LXC containers. It supports distributions such as Alpine, Arch Linux, Ubuntu, Kali, CentOS, Debian, Fedora, and more. The script is designed to work with LXC images and can also use `proot` if root access is not available.
termux run lxc-images (alpine、archlinux、ubuntu、kali、centos、debian、fedora....)

## Features
- **LXC Support:** Install and run various Linux distributions in LXC containers.
- **Proot Compatibility:** Use proot to run Linux distributions in Termux without root access.
- **Wide Range of Distributions:** Available images include Alpine, Arch Linux, Ubuntu, Kali, CentOS, Debian, Fedora, and more.
- **Custom Mirror:** Utilizes images from the [Tsinghua University Mirror](https://mirrors.tuna.tsinghua.edu.cn/lxc-images/images/).

-----

## Currently, there are two methods: with root and without!

Usage Instructions **without root**
1. Download proot-linux.sh and execute it in Termux with the command:
```bash
bash proot-linux.sh
```
> Follow the prompts in the terminal to select the Linux distribution and version. You can directly enter the name of the distribution and version available in the Tsinghua mirror (e.g., alpine edge).

> Wait for the download to complete and follow the instructions to run the corresponding startup script.

-----

**OK**, _but which one do I choose?_

## LXC vs. PRoot

# LXC (Linux Containers)
_What is it?_

**LXC** (Linux Containers) is a lightweight virtualization technology on Linux that provides a way to run multiple isolated Linux systems (containers) on a single host. It uses the Linux kernel's features to provide process isolation and resource control while sharing the same kernel.

## Key Features:

- Lightweight: LXC is lighter than traditional virtualization because it uses the host's kernel, avoiding the overhead of running a full virtual machine.

- Performance: Containers offer near-native performance since they don't require hardware emulation.
Isolation: Provides a good level of process isolation using namespaces and cgroups to control resources and visibility.

- Configuration: Requires root privileges for creating and managing containers.
Use Case: Suitable for environments where control over the system is needed, and near-host performance is crucial.

### Advantages:

- Better performance compared to full virtualization solutions.
Lower resource usage due to no hardware emulation.

- Ability to run multiple containers efficiently on the same system.

### Disadvantages:

- Requires root permissions to create and manage containers.
Less isolation compared to full virtual machines.

-------

# PRoot
_What is it?_

**PRoot** is a tool that allows running a Linux environment on Termux without root permissions, using a file system emulation mechanism. It creates a "chroot"-like environment where a file system can be mounted and executed as if it were the root.

## Key Features:

- No Root Required: PRoot allows running full Linux systems and applications in Termux without requiring root permissions.

- Chroot Simulation: Provides a chroot-like experience where a directory is treated as the root of the system, offering isolation and a complete OS-like environment.
  
- Ease of Use: Easier to set up and use, especially in environments where root access is unavailable.
  
- Performance: May be less efficient than LXC due to the additional layer of emulation and overhead.

### Advantages:

- Ideal for users without root access, enabling a full Linux environment in Termux.

- Easy to set up and use on mobile devices and restricted environments.
Less complex initial setup compared to LXC.

### Disadvantages:

Lower performance compared to LXC due to emulation overhead.
Less control over the system compared to LXC containers.

-----

## Comparison

Performance: LXC generally provides better performance because it avoids file system emulation and shares the Linux kernel. PRoot may introduce additional overhead due to emulation.

Permissions: LXC requires root permissions for creating and managing containers, whereas PRoot can be used in Termux without root access.

Isolation: LXC offers better isolation between containers and the host system than PRoot, which simulates a chroot environment.

Resource Usage: LXC is more resource-efficient as it shares the Linux kernel, while PRoot has additional overhead from emulation.
Both technologies have their specific use cases and applications. LXC is ideal for environments needing performance and isolation close to the host, while PRoot is excellent for use in restricted environments like Termux where root access is unavailable.
