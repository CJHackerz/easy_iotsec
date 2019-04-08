FROM multiarch/debian-debootstrap:armhf-stretch

WORKDIR /root
RUN mkdir workspace
VOLUME [ "/root/workspace" ]

RUN echo "Fetching neccessary packages"
RUN apt update -y
RUN apt upgrade -y
RUN apt install build-essential apt-utils systemd python python-dev python-pip python3 python3-dev python3-pip cmake pkg-config gdb wget gnupg2 git apache2 -y

RUN echo "Installing gef dependencies"
RUN pip3 install capstone==3.0.5.post1
RUN pip3 install pylint==2.3.0
RUN pip3 install ropper==1.11.6
RUN pip3 install unicorn==1.0.1

RUN echo "Going to build keystone engine for gef"
RUN git clone https://github.com/keystone-engine/keystone.git
RUN cd keystone && mkdir build && cd build && ../make-share.sh && make -j4 && make install && ldconfig
RUN cd keystone/bindings/python && make install3 && $(which python3) setup.py install
RUN rm -drf keystone/build

RUN echo "Installing gef"
RUN wget -q -O- https://github.com/hugsy/gef/raw/master/scripts/gef.sh | sh

RUN echo "Getting firmwalker and firmware-mod-lit"
RUN git clone https://github.com/craigz28/firmwalker
RUN git clone https://github.com/rampageX/firmware-mod-kit.git

CMD echo "Made by https://github.com/CJHackerz"