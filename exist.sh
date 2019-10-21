#!/bin/bash

type_exists() {
    if [ $(type -P $1) ]; then
        return 0
    fi
        return 1
}

is_os() {
    if [[ "${OSTYPE}" == $1* ]]; then
        return 0
    fi
        return 1
}

