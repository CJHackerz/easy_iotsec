#!/usr/bin/python3
import os
import subprocess

class easy_iot:

    def __init__(self):
        print("##########################################")
        print("Welcome to easy_iot-arm installer script")
        print("##########################################")
        print("> This script will install install all neccessary stuff to install arm based docker environment")
    
    def detectDocker(self):
        if subprocess.getoutput("which docker") != '/usr/bin/docker':
            print("[!]Error: Docker not found on the system")
            return False
        else:
            return True

    def installDocker(self):
        if subprocess.getoutput('lsb_release -is') == 'Ubuntu':
            print("[*]Going to install Docker on system, please enter the admin password if prompted")
            os.system("sudo apt-get update -y")
            os.system("sudo apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common -y")
            os.system("curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -")
            os.system("sudo add-apt-repository 'deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable'")
            os.system("sudo apt update -y && sudo apt-get install docker-ce docker-ce-cli containerd.io -y")
            return True
        
        elif subprocess.getoutput('lsb_release -is') == 'Debian':
            print("[*]Going to install Docker on system, please enter the admin password if prompted")
            os.system("sudo apt-get update -y")
            os.system("sudo apt-get install apt-transport-https ca-certificates curl gnupg2 software-properties-common -y")
            os.system("curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -")
            os.system("sudo add-apt-repository 'deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable'")
            os.system("sudo apt update -y && sudo apt-get install docker-ce docker-ce-cli containerd.io -y")
            return True
        
        elif subprocess.getoutput('lsb_release -is') == 'Kali':
            print("[*]Going to install Docker on system, please enter the admin password if prompted")
            os.system("sudo apt-get update -y")
            os.system("sudo apt-get install apt-transport-https ca-certificates curl gnupg2 software-properties-common -y")
            os.system("curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -")
            os.system("sudo add-apt-repository 'deb [arch=amd64] https://download.docker.com/linux/debian stretch stable'")
            os.system("sudo apt update && sudo apt-get install docker-ce docker-ce-cli containerd.io -y")
            return True

        else:
            print("[!]Error: Current script only supports Debian and Ubuntu based distros")
            return False
    
    def detectQemu(self):
        if subprocess.getoutput('which qemu-arm') != '/usr/bin/qemu-arm' or subprocess.getoutput('which qemu-arm-static') != '/usr/bin/qemu-arm-static':
            print("[!]Error: it seems qemu is not installed or some packages are missing")
            return False
        else:
            return True
    
    def installQemu(self):
        print("[*]Going to install qemu and binfmt-support for multiarch in docker")
        a = subprocess.getstatusoutput("sudo apt install qemu qemu-user-static qemu-user binfmt-support gcc-arm-linux-gnueabihf -y")
        b = subprocess.getstatusoutput("sudo docker run --rm --privileged multiarch/qemu-user-static:register")
        
        if subprocess.getoutput('echo $SHELL') == '/bin/bash':
            os.system("echo '#ARM transparent execution' >> $HOME/.bashrc")
            os.system("echo 'export QEMU_LD_PREFIX=/usr/arm-linux-gnueabihf' >> $HOME/.bashrc")

        if subprocess.getoutput('echo $SHELL') == '/usr/bin/zsh':
            os.system("echo '#ARM transparent execution' >> $HOME/.zshrc")
            os.system("echo 'export QEMU_LD_PREFIX=/usr/arm-linux-gnueabihf' >> $HOME/.zshrc")

        if a[0] == 0 and b[0] == 0:
            return True
        else: 
            False

if __name__ == '__main__':
    x = easy_iot()
    
    if x.detectDocker() == False:
        ans = input("[!]Error: Could not find docker want to install it?[y/Y/n/N] ")
        if ans == 'y' or ans == 'Y':
            status = x.installDocker()
            if status == False:
                print("[!]Error: Could not install docker can't continue")
        else:
            print("[!]Can't continue without docker, come back and rerun this script one you change your mind....")
            
    elif x.detectQemu() == False:
        ans = input("[!]Error: Could not find qemu want to install it?[y/Y/n/N] ")
        if ans == 'y' or ans == 'Y':
            status = x.installQemu()
            if status == False:
                print("[!]Error: Could not install qemu can't continue")
        else:
            print("[!]Can't continue without qemu, come back and rerun this script one you change your mind....")
    
    else:
        ans = input("[*]Everything seems fine, want to build or fetch new one?[b/f] ")
        if ans == 'b':
            print("[!]This is going to take some time have some coffee and comback :)")
            print("Please run 'sudo docker run --rm --privileged multiarch/qemu-user-static:register' command if you get any error")
            os.system("sudo docker build -t cjhackerz/easy_iotsec-arm:latest .")
            os.system("mkdir workspace")
            print("[*]Dropping you into container shell...")
            os.system("sudo docker run -it -v $PWD/workspace:/root/workspace cjhackerz/easy_iotsec-arm:latest /bin/bash")
        elif ans == 'f':
            print("[!]Going to pull container from docker hub, this requires internet connection...")
            print("Please run 'sudo docker run --rm --privileged multiarch/qemu-user-static:register' command if you get any error")
            os.system("sudo docker pull cjhackerz/easy_iotsec-arm:latest")
            os.system("mkdir workspace")
            print("[*]Dropping you into container shell...")
            os.system("sudo docker run -it -v $PWD/workspace:/root/workspace cjhackerz/easy_iotsec-arm:latest /bin/bash")
