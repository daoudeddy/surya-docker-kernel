# Kernel-Actions [![CI](https://github.com/daoudeddy/Kernel-Actions/actions/workflows/build.yml/badge.svg)]() 

Build Poco X3 nfc kernel with Github Actions, this Kernel is based on Android 13 LineageOS 20 [source code](https://github.com/LineageOS/android_kernel_xiaomi_surya)

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
sudo docker run -ti --net="host" --dns="8.8.8.8" archlinuxarm-arm64-v8
```

## Using Termux Services

Running `dockerd` as a Termux service:

Install termux-services:

`pkg install termux-services`

and then restart termux so that the service-daemon is started.

Create dockerd service:

`mkdir -p $PREFIX/var/service/dockerd/log`

`ln -sf $PREFIX/share/termux-services/svlogger $PREFIX/var/service/dockerd/log/run`

`wget https://raw.githubusercontent.com/daoudeddy/surya-docker-kernel/main/run -O $PREFIX/var/service/dockerd/run`

`chmod +x $PREFIX/var/service/dockerd/run`

Run dockerd service
`sv up dockerd`

Stop dockerd servive
`sv down dockerd $$ sudo pkill dockerd`

## More info [original post](https://gist.github.com/FreddieOliveira/efe850df7ff3951cb62d74bd770dce27)
