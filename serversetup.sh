#!/bin/bash --login
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
read -p "Press enter to continue"
echo ""


echo ">>> ruby install <<<"
if hash ruby 2>/dev/null; then
    echo "ruby already installed"
else
    rvm install ruby-2.6.3
    echo "> using default 2.6.3 ruby version"
    rvm --default use ruby-2.6.3
    echo "> show ruby version"
    ruby -v
fi
read -p "Press enter to continue"
echo ""


echo ">>> bundler install <<<"
if hash bundler 2>/dev/null; then
    echo "bundler already installed"
else
    gem install bundler
fi
read -p "Press enter to continue"
echo ""



echo ">>> rails install <<<"
if hash rails 2>/dev/null; then
    echo "rails already installed"
else
    gem install rails
    rails -v
fi
read -p "Press enter to continue"
echo ""


echo ">>> creating user for rails application <<<"
user='gingerbird'
echo "> testing user existence"
if [ $(getent passwd $user) ] ; then
        echo user $user exists
else
        echo user $user doesn\'t exists
        echo "> creating user"
        sudo adduser $user
        if [ $(getent passwd $user) ] ; then
            echo user $user exists now !
        fi
fi
read -p "Press enter to continue"
echo ""











