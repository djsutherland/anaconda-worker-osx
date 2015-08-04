#!/usr/bin/env bash
# Wrapper because launchctl doesn't set PATH properly
# http://www.openradar.me/18945659

QUEUE=$1
ANACONDA=${2:-"$HOME/miniconda"}

export PATH="$ANACONDA/bin:$PATH"
anaconda-build -t ~/.binstar.token worker $QUEUE
