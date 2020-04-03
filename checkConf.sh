#!/bin/bash

source /home/forz/Projects/script/confermation.sh
source /home/forz/Projects/script/setAsset.sh


seek_confirmation "Vuoi stampare un messaggio di successo?"
if is_confirmed; then
    e_success "Ecco un messaggio di successo"
else
    e_error "Non hai chiesto un messaggio di successo"
fi
