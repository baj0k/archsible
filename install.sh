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

ansible-galaxy collection install kewlfft.aur
rsync -av -e ssh --exclude='.git' $(whoami)@desktop:/home/$(whoami)/fieldwork/archsible ~/
ansible-playbook -i hosts main.yml -vv
