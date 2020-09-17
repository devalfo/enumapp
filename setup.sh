#!/bin/bash
echo '[+]-Welcome to the setup'
#Update
apt-get update 
apt-get upgrade
#tools requirement
apt-get install python
apt-get install python3
apt-get install python-pip
apt-get install python3-pip
apt-get install git
# installing tools
#tools used :
#nikto , nmap , Sublist3er
apt-get install nmap
apt-get install dirb
apt-get install nikto 
cd /opt 
git clone https://github.com/aboul3la/Sublist3r.git
#special thanks to aboul3la for using his tool 
cd 
#sublist3r requirements
pip install -r requirements.txt