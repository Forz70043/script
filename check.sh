#!/bin/bash

source /home/forz/Projects/script2/exist.sh
source /home/forz/Projects/script2/setAsset.sh
source /home/forz/Projects/script2/confermation.sh

e_header "Check Packages"

if type_exists "$1" ; 
then
	e_success "OK, $1 already installed"
	version=`$1 --version`
	e_arrow " version:  $version"
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





