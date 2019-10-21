#!/bin/bash

source /home/Project/script/exist.sh
source /home/Project/script/setAsset.sh

e_header "Check Packages"

if type_exists "$1" ; 
then
        e_success "OK, $1 already installed"
else 
        e_error "$1, not installed "
        e_note "Do you want to install it ?"
fi
