#!/bin/bash

source /home/alternet.italfonso/Project/script/exist.sh
source /home/alternet.italfonso/Project/script/setAsset.sh
source /home/alternet.italfonso/Project/script/confermation.sh

e_header "Check Packages"

if type_exists "$1" ; 
then
	e_success "OK, $1 already installed"
else 
	e_error "$1, not installed "
	#e_note "Do you want to install it ?"
	seek_confirmation "Do you want to install it?"
	if is_confirmed; then
		sudo dnf install $1
		if [ "$?" eq 0 ]
		then
			e_success "$1 installed successfull"
		else
			e_error "Something went wrong!"
		fi
	else
		e_underline "You have choose to not install it"
	fi

fi





