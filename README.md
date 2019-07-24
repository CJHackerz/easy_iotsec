# easy_iotsec-arm

Contains python script to build armv7 based debian container environment for static binary analysis

## Features

* Automatically installs docker and qemu
* Enables binfmt_support and Transparent binary execution for ARM
* Mounts directory called worksapce from container to move files easily
* Builds gef exetension for GDB or comes pre-installed if pulled from dockerhub
* Has latest version of radare2 installed
* Has firmwalker and firmware-mod-kit in container's /root

## Installation

```bash
pip3 install -r requirements.txt
```

```bash
chmod +x launch.py
```

```
./launch.py
```

Follow the prompts from python script at the end it will drop you into shell of the container

## Usage

__Just spawn shell__


```bash
sudo docker run -it cjhackerz/easy_iotsec-arm /bin/bash
```

*if you already have docker on system simply run qemu_install.sh script from scripts directory and above command will fetch container image from docker hub built by me*

__Syntax to expose ports__


```bash
sudo docker run -it -p localport1,localport2,localportN:containerport1,containerport1,containerportN cjhackerz/easy_iotsec-arm /bin/bash
```

For example if you wanna access web service from container

```bash
sudo docker run -it -p 80:80 cjhackerz/easy_iotsec-arm /bin/bash
```

__To mount specific directory__ *defaults to workspace directory if running via python script*

```bash
sudo docker run -it -v full_path_hostdir:full_path_containerdir cjhackerz/easy_iotsec-arm /bin/bash
```


For more information please visit Docker's official documentation: [Here](https://docs.docker.com/engine/reference/run/)
