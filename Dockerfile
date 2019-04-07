FROM arm32v7/debian

WORKDIR /root
VOLUME [ "/root" ]

RUN apt update -y
RUN apt upgrade -y
RUN apt install build-essential python python-dev python-pip python3 python3-dev python3-pip cmake gdb wget gnupg2 git apache2 -y
RUN pip3 install capstone==3.0.5.post1
RUN pip3 install keystone-engine==0.9.1.post3
RUN pip3 install pylint==2.3.0
RUN pip3 install ropper==1.11.6
RUN pip3 install unicorn==1.0.1
RUN wget -q -O- https://github.com/hugsy/gef/raw/master/scripts/gef.sh | sh
RUN git clone https://github.com/craigz28/firmwalker
RUN git clone https://github.com/rampageX/firmware-mod-kit.git

CMD echo "Made by CJHackerz"