#!/bin/bash


if [ -z "$1" ]
then
	DIR=./
else
	DIR=$1
fi

echo "Evaluate *.php statistics"
FILES=$(find $DIR -name '*.php' | wc -l)
LINES=$( (find $DIR -name '*.php' -print0 | xargs -0 cat) | wc -l)


echo "PHP FILES: $FILES"
echo "PHP LINES: $LINES"



