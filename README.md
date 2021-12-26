# Kernel-Actions [![CI](https://github.com/daoudeddy/Kernel-Actions/actions/workflows/build.yml/badge.svg)]() 

Build Poco X3 nfc kernel with Github Actions

## Adding docker support on Android Kernel
You can find the Kernel Image in the [release](https://github.com/daoudeddy/Kernel-Actions/releases) tab

## Docker can be run on [Termux](https://github.com/termux/termux-app) by running the following commands

```shellscript
pkg install root-repo
pkg install docker tsu
```
## Preparing docker environment

```bash
sudo mount -t tmpfs -o mode=755 tmpfs /sys/fs/cgroup
sudo mkdir -p /sys/fs/cgroup/devices
sudo mount -t cgroup -o devices cgroup /sys/fs/cgroup/devices
```
These commands need to be exectuded after every reboot

## Running dockerd

```bash
sudo dockerd &
```

## Pulling and running docker container

```bash
sudo docker pull agners/archlinuxarm-arm64-v8
sudo docker run -to --net="host" --dns="8.8.8.8" archlinuxarm-arm64-v8
```

More info [original post](https://gist.github.com/FreddieOliveira/efe850df7ff3951cb62d74bd770dce27)
