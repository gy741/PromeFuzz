#!/bin/bash

DEPS="cmake zlib1g-dev libdbus-glib-1-dev build-essential doxygen graphviz libjson-c-dev"
if [ "$EUID" -eq 0 ]; then
    apt install $DEPS
else
    sudo apt install $DEPS
fi
