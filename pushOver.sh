#!/bin/bash

pushover () {
    PUSHOVERURL="https://api.pushover.net/1/messages.json"
    API_KEY="your-api-here"
    USER_KEY="u3s234fg7rr9mwmbhyh6qpso5yyhb7"
    DEVICE=""
    MAILTO="4iohf7h961@pomail.net"

    TITLE="${1}"
    MESSAGE="${2}"

    curl \
    -F "token=${API_KEY}" \
    -F "user=${USER_KEY}" \
    -F "device=${DEVICE}" \
    -F "title=${TITLE}" \
    -F "message=${MESSAGE}" \
    "${PUSHOVERURL}" > /dev/null 2>&1
}


