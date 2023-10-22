# FreeBSDGSM Game Server Containers

<p align="center">
    <img src="https://cdn.t2v.city/content/vSKyC7YoiXXpaUMHd76H/freebsdgsm.sh/FreeBSDGSM.png" alt="LinuxGSM" style="width:500px;">
<br>
  <img src="https://cdn.t2v.city/archival-data/hi.gif" alt="LinuxGSM" style="width:40px;">
<a href="https://github.com/t2vee/FreeBSDGSM/blob/main/LICENSE_lgsm"><img alt="Static Badge" src="https://img.shields.io/badge/LinuxGSM_license-MIT-lime?style=flat-square&logo=gpl"></a>
	<a href="https://github.com/t2vee/FreeBSDGSM/blob/main/LICENSE_fbsdgsm"><img alt="Static Badge" src="https://img.shields.io/badge/FreeBSDGSM_license-GPLv3-darkred?style=flat-square&logo=gpl"></a>
  <img src="https://cdn.t2v.city/archival-data/hi.gif" alt="LinuxGSM" style="width:40px;">

---
> Warning: This README is currently pseudo. There will be many, many changes to how things may work but for now this is how I hope to see it work.
## About
FreeBSDGSM is the LinuxGSM compatibility layer for FreeBSD. This repo holds the [pot images](https://pot.pizzamig.dev/Images/) for all the games servers provided by fgsm.
All the available images are listed within this repo using their respective server name; e.g TeamFortress 2 is tf2server.

For a list of available game servers visit [linuxgsm.com](https://linuxgsm.com) or the [serverlist.ssv](https://github.com/GameServerManagers/LinuxGSM/blob/master/fbsdgsm/data/serverlist.ssv).

---

## Usage
These containers can be run 1 of 2 ways:
- Standalone Container
  - Helper Script
- Automatically created by FreeBSDGSM when installed as a plugin
  - pot (freebsd as the base distro)
  - qemu (windows or linux as the base distro)

---

## FreeBSDGSM Pot Plugin
The main freebsdgsm.sh script has the ability to automatically install/run/manage server in pot containers.
To get started make sure you have the required pkg repository installed:
```
$ doas curl -o /usr/local/etc/pkg/repos/FreeBSDGSM.conf "https://pkgs.freebsdgsm.org/Config/FreeBSDGSM.conf"
$ doas pkg update
```
Make sure that FreeBSDGSM is installed:
```
$ doas pkg install freebsdgsm
```
Now install the pot orchestrator plugin:
```
$ doas pkg install freebsdgsm-pot-plugin
```
Run freebsdgsm like usual but include the --container flag. e.g:
```
# Installing Team Fortress 2 Server
$ freebsdgsm tf2 --container
```
Easy as that! Your server will now be running in a jail separated from

---

### Standalone (Assisted)
To auto download and process server images, you can use the provided assistance script.
This script will take care of host dependencies like most importantly pot itself.

```
### tf2server from the freebsdgsm cdn (Stable):

## Download Helper Script
$ curl -O -L https://freebsdgsm.org/ContainerInstall.sh
$ doas chmod +x ContainerInstall.sh
$ ./ContainerInstall.sh tf2
```
```
### tf2server via github instead (Rolling Release):

## Download Helper Script
$ curl -O -L https://raw.githubusercontent.com/t2vee/FBSDGSM-Containers/main//ContainerInstall.sh
$ doas chmod +x ContainerInstall.sh
$ ./ContainerInstall.sh tf2
```
There you go! Simple as that.

### Standalone (Manual)
To run an image standalone simply download the pot image to your FreeBSD server:
> NOTE: You must have pot installed yourself and any other required dependencies!
```
### tf2server from the freebsdgsm cdn (Stable):

## Download Main Container Image
$ curl -O -L https://images-cdn.freebsdgsm.org/latest/tf2server.xz
## Download Container Image Hash
$ curl -O -L https://images-cdn.freebsdgsm.org/latest/tf2server.xz.skein
## Import and create pot
$ doas pot import -p tf2server -t latest -U file://tf2server.xz
```

```
### tf2server server via github instead (Rolling Release):

## Download Main Container Image
$ curl -O -L https://raw.githubusercontent.com/t2vee/FBSDGSM-Containers/main/tf2/tf2server.xz
## Download Container Image Hash
$ curl -O -L https://raw.githubusercontent.com/t2vee/FBSDGSM-Containers/main/tf2/tf2server.xz.skein
## Import and create pot
$ doas pot import -p tf2server -t latest -U file://tf2server.xz
```

---

## FreeBSDGSM Qemu Plugin (UNSTABLE)
The main freebsdgsm.sh script has the ability to automatically install/run/manage server in qemu virtual machines for game servers that have limited compatibility with linux or bsd servers.
> At the moment due to the nature of this plugin, support will NOT be provided for its usage

For Qemu support you not only need the base repository but the development repository:
```
### Base Repo
$ doas curl -o /usr/local/etc/pkg/repos/FreeBSDGSM.conf "https://pkgs.freebsdgsm.org/Config/FreeBSDGSM.conf"
### Development Repo
$ doas curl -o /usr/local/etc/pkg/repos/FreeBSDGSM-UNSTABLE.conf "https://pkgs.freebsdgsm.org/Config/FreeBSDGSM-UNSTABLE.conf"
### Enable Them
$ doas pkg update
```
Make sure that FreeBSDGSM is installed:
```
$ doas pkg install freebsdgsm
```
Now install the qemu orchestrator plugin:
```
$ doas pkg install freebsdgsm-qemu-plugin
```
Run freebsdgsm like usual, but you will need to include a few flags:
- --vm
  - to pass off the game server install to the qemu plugin.
- --force-sha-integrity-check
  - since this method is quite unstable all files must have their integrity checked.
  - the script will NOT run without this option.
- --check-compat
  - to tell the main installation script to check whether the desired game can be installed via qemu

```
# Installing a Satisfactory Server
$ freebsdgsm sf --vm --force-sha-integrity-check --check-compat
```


