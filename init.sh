#!/bin/bash

branch="develop"

setup_one() {
    cd repos &&
    git clone -b ${branch} https://github.com/Viva-con-Agua/${1}.git && 
    mkdir ../config/${1} &&
    cp -r ${1}/config/* ../config/${1}/
    cd ..
}

setup_all(){
    ( setup_one mail-backend || echo "cant reinstall mail-backend" ) &&
    ( setup_one auth-backend || echo "cant reinstall auth-backend" ) 
}
case $1 in
    one) setup_one $2;;
    all) setup_all;;
    *) print_help
esac
