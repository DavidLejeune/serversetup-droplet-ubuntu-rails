#!/bin/bash --login
clear
echo "========================================================================"
echo "Install script to deploy Rails app on Ubuntu 18.04 digital ocean droplet"
echo "========================================================================"
echo ""
sleep 2


echo ">>> RVM install <<<"
if hash rvm 2>/dev/null; then
    echo "RVM already installed"
else
    sudo apt-get install software-properties-common
    sudo apt-add-repository -y ppa:rael-gc/rvm
    sudo apt-get update
    sudo apt-get install rvm
    sudo usermod -a -G rvm `whoami`
    echo "Please exit out of the ssh connection , reconnect and run script again"
    exit
fi
sleep 1
#read -p "Press enter to continue"
echo ""


echo ">>> ruby install <<<"
if hash ruby 2>/dev/null; then
    echo "ruby already installed"
    ruby -v
else
    rvm install ruby-2.6.3
    echo "> using default 2.6.3 ruby version"
    rvm --default use ruby-2.6.3
    echo "> show ruby version"
    ruby -v
fi
sleep 1
#read -p "Press enter to continue"
echo ""


echo ">>> bundler install <<<"
if hash bundler 2>/dev/null; then
    echo "bundler already installed"
    bundle --version
else
    gem install bundler
    bundle --version
fi
sleep 1
#read -p "Press enter to continue"
echo ""



echo ">>> rails install <<<"
if hash rails 2>/dev/null; then
    echo "rails already installed"
    rails -v
else
    gem install rails
    echo "> show version"
    rails -v
fi
sleep 1
#read -p "Press enter to continue"
echo ""


echo ">>> creating user for rails application <<<"
user='myappuser'
echo "> testing user existence"
if [ $(getent passwd $user) ] ; then
        echo user $user exists
        id $user
else
        echo user $user doesn\'t exists
        echo "> creating user"
        sudo adduser $user
        if [ $(getent passwd $user) ] ; then
            echo user $user exists now !
        fi
        usermod -aG sudo $user
        echo "> copying HOME ssh key to here"
        sudo mkdir -p /home/$user/.ssh
        touch $HOME/.ssh/authorized_keys
        sudo sh -c "cat $HOME/.ssh/authorized_keys >> /home/$user/.ssh/authorized_keys"
        sudo chown -R $user: /home/$user/.ssh
        sudo chmod 700 /home/$user/.ssh
        sudo sh -c "chmod 600 /home/$user/.ssh/*"


fi
sleep 1
#read -p "Press enter to continue"
echo ""

echo ">>> yarn install <<<"
if hash yarn 2>/dev/null; then
    echo "yarn already installed"
    yarn --version
else
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
    sudo apt update
    sudo apt install yarn
    echo "> show version"
    yarn --version
fi
sleep 1
#read -p "Press enter to continue"
echo ""


echo ">>> pulling the code <<<"
myapp='myapp'
DIR=/var/www/$myapp
repo='git@github.com:DavidLejeune/ilafirouzabadi.git'
if [ -d "$DIR" ]; then
  # Take action if $DIR exists. #
  echo "${DIR} Already exists ..."
else
    sudo mkdir -p /var/www/$myapp
    sudo chown $user: /var/www/$myapp
    cd $DIR
    sudo -u $user -H git clone $repo code
fi
sleep 1
#read -p "Press enter to continue"
echo ""









