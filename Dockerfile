FROM arm32v7/armhf-debian

WORKDIR /root

RUN apt update -y
RUN apt upgrade -y
RUN apt install build-essential python python-dev python-pip python3 python3-dev python3-pip gnupg2 git apache2 -y
RUN pip3 install capstone
RUN pip3 install unicorn
RUN pip3 install keystone-engine
RUN pip3 install ropper
RUN pip3 install pylint
RUN wget -q -O- https://github.com/hugsy/gef/raw/master/scripts/gef.sh | sh
RUN git clone https://github.com/craigz28/firmwalker
RUN git clone https://github.com/rampageX/firmware-mod-kit.git

CMD echo "Made by CJHackerz"