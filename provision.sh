#!/usr/bin/env bash


echo -e "--- DB2 9.7 on Ubuntu 12.04 LTS ---"
echo -e "--- updating system- --"

cat << EOF | sudo tee -a /etc/motd.tail
***************************************
     ____  ____ ____     ___  _____
    |  _ \| __ )___ \   / _ \|___  |
    | | | |  _ \ __) | | (_) |  / /
    | |_| | |_) / __/   \__, | / /
    |____/|____/_____|    /_(_)_/

Welcome to Ubuntu 12.04 Precise Penguin DB2 9.7
             Vagrant Box

***************************************
EOF

echo 'deb http://archive.canonical.com/ubuntu precise partner' >/tmp/myppa.list
echo 'deb-src http://archive.canonical.com/ubuntu precise partner' >>/tmp/myppa.list
cp /tmp/myppa.list /etc/apt/sources.list.d/
rm /tmp/myppa.list

echo -e "\n--- Updating packages list ---\n"
apt-get -qq update --fix-missing
echo -e "\n--- Install packages ---\n"
apt-get install -y -qq build-essential \
                   vim \
                   tree \
                   mc \
                   tmux \
                   git-core \
                   db2exc
echo -e "\n--- Upgrade packages ---\n"
apt-get upgrade -y -qq
apt-get clean -y -qq
echo -e "\n--- change database user db2inst1 password to db2inst1 ---\n"
echo -e "db2inst1\ndb2inst1" | passwd db2inst1 -q
echo -e "\n--- Install sample database ---\n"
su db2inst1 <<'EOF'
    /home/db2inst1/sqllib/bin/db2sampl
    /home/db2inst1/sqllib/bin/db2 -p 'attach to db2inst1'
    /home/db2inst1/sqllib/bin/db2 -p 'get dbm cfg show detail'
EOF
sudo dpkg -i /vagrant/ibm-java-x86-64-sdk_6.0-10.2_amd64.deb
su db2inst1 <<'EOF'
    sh /vagrant/java.sh
EOF
sudo rm -rf /etc/udev/rules.d/70-persistent-net.rules