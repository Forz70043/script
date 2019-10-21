#!/bin/bash

source /home/alternet.italfonso/Project/script/setAsset.sh

seek_confirmation() {
    printf "\n${bold}$@${reset}"
    read -p " (y/n) " -n 1
    printf "\n"
}


# Test whether the result of an 'ask' is a confirmation
is_confirmed() {
    if [[ "$REPLY" =~ ^[Yy]$ ]]; then
        return 0
    fi
        return 1
}



