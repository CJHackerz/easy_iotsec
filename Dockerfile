FROM multiarch/debian-debootstrap:armhf-stretch

WORKDIR /root
RUN ["/usr/bin/qemu-arm-static", "mkdir workspace"]
VOLUME ["/root/workspace"]

RUN ["/usr/bin/qemu-arm-static", "echo 'Fetching neccessary packages'"]
RUN ["/usr/bin/qemu-arm-static", "apt update -y"]
RUN ["/usr/bin/qemu-arm-static", "apt upgrade -y"]
RUN ["/usr/bin/qemu-arm-static", "apt install build-essential apt-utils systemd python python-dev python-pip python3 python3-dev python3-pip cmake pkg-config gdb wget gnupg2 git apache2 -y"]

RUN ["/usr/bin/qemu-arm-static", "echo 'Installing gef dependencies'"]
RUN ["/usr/bin/qemu-arm-static", "pip3 install capstone==3.0.5.post1"]
RUN ["/usr/bin/qemu-arm-static", "pip3 install pylint==2.3.0"]
RUN ["/usr/bin/qemu-arm-static", "pip3 install ropper==1.11.6"]
RUN ["/usr/bin/qemu-arm-static", "pip3 install unicorn==1.0.1"]

RUN ["/usr/bin/qemu-arm-static", "echo 'Going to build keystone engine for gef'"]
RUN ["/usr/bin/qemu-arm-static", "git clone https://github.com/keystone-engine/keystone.git"]
RUN ["/usr/bin/qemu-arm-static", "cd keystone && mkdir build && cd build && ../make-share.sh && make -j4 && make install && ldconfig"]
RUN ["/usr/bin/qemu-arm-static", "cd keystone/bindings/python && make install3 && $(which python3) setup.py install"]
RUN ["/usr/bin/qemu-arm-static", "rm -drf keystone/build"]

RUN ["/usr/bin/qemu-arm-static", "echo 'Installing gef'"]
RUN ["/usr/bin/qemu-arm-static", "wget -q -O- https://github.com/hugsy/gef/raw/master/scripts/gef.sh | sh"]

RUN ["/usr/bin/qemu-arm-static", "echo 'Getting firmwalker and firmware-mod-lit'"]
RUN ["/usr/bin/qemu-arm-static", "git clone https://github.com/craigz28/firmwalker"]
RUN ["/usr/bin/qemu-arm-static", "git clone https://github.com/rampageX/firmware-mod-kit.git"]

CMD ["/usr/bin/qemu-arm-static", "echo 'Made by https://github.com/CJHackerz'"]