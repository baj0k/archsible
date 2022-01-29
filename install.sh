#!/bin/sh

#help() {
#    echo "Usage: ./install [-p arg] [-w arg] [-d arg] [-g arg]"
#    echo "-p (the password for the private mail account)"
#    echo "-d (the password for the cal- and carddav account)"
#    echo "-g (the password for the github account)"
#    echo "-h (print this message)"
#}
#
#while getopts ':p:w:d:g:h' opt; do
#    case $opt in
#        p)
#            private_pw=$OPTARG
#            ;;
#        d)
#            dav_pw=$OPTARG
#            ;;
#        g)
#            github_pw=$OPTARG
#            ;;
#        h)
#            help
#            exit
#            ;;
#        ?)
#            echo "Invalid Parameter given. $(help)"
#            ;;
#    esac
#done

mkdir -p ~/.ansible/plugins/modules
curl -o ~/.ansible/plugins/modules/aur.py https://raw.githubusercontent.com/kewlfft/ansible-aur/master/plugins/modules/aur.py

rsync -av -e ssh --exclude='.git' $(whoami)@desktop:/home/$(whoami)/repos/archsible ~/
ansible-playbook -i hosts main.yml -vv
