#!/bin/bash
set -e

function start(){
    exec npx screeps start
}

function install(){
    npm install screeps@$SCREEPS_VER
    npx screeps init
}

cd $WORKDIR

case $1 in
    install)
        install
        ;;
    start)
        start
        ;;
    *)
        exec "$@"
        ;;
esac
