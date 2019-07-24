FROM arm32v7/debian
WORKDIR /root
RUN mkdir workspace
#Mount point for workspace dir
VOLUME [ "/root/workspace" ]
#Package manager repo update and installing required stuff
RUN apt update -y && apt upgrade -y
RUN apt install build-essential cmake python python-dev python-pip python3 python3-dev python3-pip cmake gdb wget gnupg2 git apache2 toilet -y
#Python packages required by gef
RUN pip3 install pylint
RUN pip3 install ropper
RUN pip3 install unicorn
#Keystone Assembler compilation
RUN git clone https://github.com/keystone-engine/keystone.git
RUN cd keystone && mkdir build && cd build && ../make-share.sh && make install && ldconfig
RUN cd keystone/bindings/python && make install3
#Gef install script
RUN wget -q -O- https://github.com/hugsy/gef/raw/master/scripts/gef.sh | sh
#Radare2 installation
RUN git clone https://github.com/radare/radare2.git && cd radare2 && ./sys/install.sh
#Extra tools for IoT sec
RUN git clone https://github.com/craigz28/firmwalker
RUN git clone https://github.com/rampageX/firmware-mod-kit.git
#Setting correct unicode environment variable for bash shell to aviod wierd exeception errors in gef
RUN echo "export LC_CTYPE=C.UTF-8" >> .bashrc
#Custom banner and some privacy quotes from edward snowden
COPY banners/quotes.txt /opt
RUN echo "toilet -f future Easy IoT Sec -F border && echo -e '\e[1m> Made by \e[91mCJHackerz\e[0m \e[1m\e[93m[https://cjhackerz.net] \e[0m \n' && cat /opt/quotes.txt | shuf -n 1" >> .bashrc