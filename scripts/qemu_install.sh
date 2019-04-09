#!/bin/bash
sudo apt install qemu qemu-user-static qemu-user binfmt-support gcc-arm-linux-gnueabihf -y
sudo docker run --rm --privileged multiarch/qemu-user-static:register