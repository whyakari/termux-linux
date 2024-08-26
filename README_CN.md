## Termux-Linux

**简体中文** | [English](README.md)

此脚本使您能够使用 LXC 容器在 Termux 上运行各种 Linux 发行版。它支持 Alpine、Arch Linux、Ubuntu、Kali、CentOS、Debian、Fedora 等发行版。 脚本旨在与 LXC 镜像配合使用，如果无法使用 root 权限，还可以使用 `proot` termux run lxc-images (alpine、archlinux、ubuntu、kali、centos、debian、fedora...)。

## 功能

- **LXC 支持:** 在 LXC 容器中安装和运行各种 Linux 发行版。
- **Proot 兼容性:** 在没有 root 权限的情况下使用 proot 在 Termux 中运行 Linux 发行版。
- **广泛的发行版支持:** 可用镜像包括 Alpine、Arch Linux、Ubuntu、Kali、CentOS、Debian、Fedora 等。
- **自定义镜像源:** 使用来自 [清华大学镜像](https://mirrors.tuna.tsinghua.edu.cn/lxc-images/images/) 的镜像。

> **警告：目前有两种安装方式：**  一种**需要 root 权限**，另一种**无需 root 权限**！

## ⚠️ 指南：无需 root 权限安装 Linux 发行版 

### 如何**无需 root 权限**安装 Linux 发行版

<details>
<summary>展开查看</summary>

1. 下载 proot-linux.sh 脚本并使用 Termux 执行以下命令：

```bash
chmod +x proot-linux.sh && ./proot-linux.sh
```

> 按照终端提示选择 Linux 发行版和版本。可以直接输入清华镜像源可用的发行版名称和版本号（例如：alpine edge）。

> 等待下载完成，然后按照提示运行相应的启动脚本。

</details>

### 如何**使用 root 权限**安装 Linux 发行版

<details>
<summary>展开查看</summary>

```bash
pkg i tsu -y
tsu
chmod +x lxc-linux.sh && ./lxc-linux.sh
```

</details>

**好的，** 但我该如何选择？

## LXC vs. PRoot

# LXC (Linux 容器)

_它是什么？_

**LXC** (Linux Containers) 是 Linux 上一种轻量级的虚拟化技术，它提供了一种在单个主机上运行多个隔离的 Linux 系统（容器）的方式。它利用 Linux 内核的功能来提供进程隔离和资源控制，同时共享相同的内核。

## 主要功能:

- **轻量级:** LXC 因为使用主机内核而比传统虚拟化更轻量级，避免了运行完整虚拟机的开销。

- **性能:** 由于不需要硬件仿真，容器提供接近本机的性能。

- **隔离:** 使用命名空间和控制组提供良好的进程隔离，以控制资源和可见性。

- **配置:** 创建和管理容器需要 root 权限。

- **用例:** 适用于需要控制系统且接近主机性能至关重要的环境。

### 优点:

- 与完整的虚拟化解决方案相比，性能更好。
- 由于没有硬件仿真，因此资源使用率更低。

- 能够在同一系统上高效运行多个容器。

### 缺点:

- 创建和管理容器需要 root 权限。
- 与完整虚拟机相比，隔离性较差。

-------

# PRoot

_它是什么？_

**PRoot** 是一个工具，它允许在 Termux 上使用文件系统仿真机制运行 Linux 环境，而无需 root 权限。它创建了一个类似于 chroot 的环境，可以在其中挂载文件系统并执行，就像它是根目录一样。

## 主要功能:

- **无需 Root 权限:** PRoot 允许在 Termux 中运行完整的 Linux 系统和应用程序，而无需 root 权限。

- **Chroot 模拟:** 提供类似于 chroot 的体验，其中一个目录被视为系统的根目录，提供隔离和完整的类操作系统环境。

- **易于使用:** 特别是在无法使用 root 权限的环境中，设置和使用更简单。

- **性能:** 由于额外的仿真层和开销，可能比 LXC 效率更低。

### 优点:

- 非常适合没有 root 权限的用户，可以在 Termux 中启用完整的 Linux 环境。

- 易于在移动设备和受限环境中设置和使用。
- 与 LXC 相比，初始设置更简单。

### 缺点:

- 由于仿真开销，性能低于 LXC。
- 与 LXC 容器相比，对系统的控制更少。

-----

## 比较

性能: LXC 通常提供更好的性能，因为它避免了文件系统仿真并共享 Linux 内核。 PRoot 可能会因仿真而引入额外的开销。

权限: LXC 创建和管理容器需要 root 权限，而 PRoot 可以 在 Termux 中无需 root 权限使用。

隔离: LXC 在容器和主机系统之间提供比 PRoot 更好的隔离，后者模拟 chroot 环境。

资源使用: LXC 共享 Linux 内核，因此更加节约资源，
