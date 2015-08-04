#!/bin/bash
# Wrapper because launchctl doesn't set PATH properly
# http://www.openradar.me/18945659

read -r QUEUE < ~/queuename
ANACONDA=${1:-"$HOME/miniconda"}

cd
export PATH="$ANACONDA/bin:$PATH"
anaconda-build -t ~/.binstar.token worker $QUEUE
