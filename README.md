# easy_iotsec-arm

Contains python script to build armv7 based debian container environment for static binary analysis

## Features

* Automatically installs docker and qemu
* Enables binfmt_support and Transparent binary execution for ARM
* Mounts directory called worksapce from container to move files easily
* Builds gef exetension for GDB or comes pre-installed if pulled from dockerhub
* Has firmwalker and firmware-mod-kit in container's /root

## Installation

```console
chmod +x launch.py
./launch.py
```

Follow the prompts from python script at the end it will drop you into shell of the container

## Usage

Syntax to expose ports

```console
sudo docker run -it -p localport1,localport2,localportN:containerport1,containerport1,containerportN cjhackerz/easy_iotsec-arm /bin/bash
```

For example if you wanna access web service from container

```console
sudo docker run -it -p 80:80 cjhackerz/easy_iotsec-arm /bin/bash
```

To mount specific directory

```console
sudo docker run -it -v full_path_hostdir:full_path_containerdir cjhackerz/easy_iotsec-arm /bin/bash
```
For more information please visit Docker's official documentation: [Here](https://docs.docker.com/engine/reference/run/)
