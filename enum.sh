#!/bin/bash 
echo '''
___________                                          
\_   _____/ ____  __ __  _____ _____  ______ ______  
 |    __)_ /    \|  |  \/     \\__  \ \____ \\____ \ 
 |        \   |  \  |  /  Y Y  \/ __ \|  |_> >  |_> >
/_______  /___|  /____/|__|_|  (____  /   __/|   __/ 
        \/     \/            \/     \/|__|   |__|    


                                               RUN IT AND GO MAKE UR COFFEE :)
                                               V 0.1
'''

# GHATHERING INFOS ABOUT THE SCAN OPPERATION 
# AND AJUSTING OPTIONS FOR THE SCAN 
echo '[!]-Hello and welcome to my automates script for ctf scan'
echo '[!]-This tool is not perfect it need more developement ,so please dont judge me ,thanks :)'
read -p "[+]-What's the name of your CTF or domain machine ? :  " CTF
echo '[+]-The name of your machine is : ' $CTF 
read -p "[+]-What is the IP of the machine ? : " IP
echo '[+]-The IP ot the domain of your machine is : ' $IP     # i just make it ip cause the script is actually made for ctf 
# THE AJUSTEMENT OF OPTIONS 
read -p '[!]-Dirb scan will start add a port ? (default 80) : ' $port 
# CREATING INFO ABOUT THE SCAN AND TO STORE IT IN
# THIS IS THE AUTOMATED PART  
mkdir $CTF 
cd $CTF 
# RUNNING THE SCAN 
# THIS SCAN CONTAIN TREE TOOLS : NMAP , DIRB , NIKTO , MAYBE LATER I WILL ADD SOME MORE THINGS 
echo '[=]-Machine name : ' $CTF '(' $IP ')' >> $CTF.txt
echo '[+]-Nmap agressive scan : ' >> $CTF.txt
echo '[+]-Nmap is starting'
nmap -A -T4 $IP -oN nmapscan.txt 
echo '[+]-Your nmap scan is : '
cat nmapscan.txt
# the web enumeration
function web() {
        echo '[+]-Dirb scan : ' >> $CTF.txt
        echo '[+]-Dirb is starting' 
        dirb http://$IP:$port /usr/share/wordlists/dirb/small.txt -X ".php,.txt" -o dirb.txt
        echo '[+]-Nikto scan :' >> $CTF.txt
        nikto -h http://$IP -output nikto.txt 
        # SUBLISTER FOR SUBDOMAINS
        if [ 'www' or '.com' or ".org" in $IP]
        then 
                echo '[+]-Bruteforcing subdomains'
                cd /opt/Sublist3r
                python sublist3r.py -d "http://$IP" -v -b -t 4 -o sublist3r.txt
        fi
}
#detecting the http in the nmap scan 
HTT = "80"
HTTS = "443"
function detection() {
        if grep -Fxq "$HTT" nmapscan.txt
        then
                echo '[!]-Port 80/443 found'
                echo '[+]-Website enumeratin gonna start ...'
                web
        else
                echo '[+]-HTTP/S not found '
        fi
}
detection

echo "[-]-Your scan is completed , yeah it wasn't all tools you wanted but this tool will save you alot of time ."
echo "[-]-Please suggess me some tools to add to the script , thanks"
read -p '[?]-Wanna see your result ? [y/n] ' result
#SHOWING THE OUTPUT FILES TO THE USER 
if ["$result" = "y"];
then
        echo '[-]-Nmap scan : '
        cat nmapscan.txt
        echo '[-]-Dirb scan : '
        cat dirb.txt
        echo '[-]-Nikto scan : '
        cat nikto.txt 
else 
        echo '        BYE!!!'
