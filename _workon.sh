#!/bin/bash

workon_usage () {
    echo "Usage: workon <project lookup>"
    echo "Project lookup can be a project name or a path."
}

# Test if an argument is given else print the usage help text
if [ -z $1 ]
    then
        workon_usage
        return 1
fi

echo "Deactivating the current virtual env"
# Deactivate any current environment "destructively"
# before switching so we use our override function,
# if it exists.
type deactivate >/dev/null 2>&1
if [ $? -eq 0 ]
    then
        deactivate
        unset -f deactivate >/dev/null 2>&1
fi

echo "Looking for project $1"
OUTPUT=`python ~/.workon.py $1`

OIFS=$IFS
set -- $OUTPUT
IFS=","; declare -a Array=($*)
IFS=$OIFS

echo "output $OUTPUT"
echo "${Array[@]}"

PROJECT_DIR=${Array[0]}
ACTIVATION_FILE=${Array[1]}

echo "Project dir $PROJECT_DIR"
echo "activation  file $ACTIVATION_FILE"

if [ -d $PROJECT_DIR ] 
    then
        cd $PROJECT_DIR
fi

if [ -f $ACTIVATION_FILE ]
    then
        source $ACTIVATION_FILE
fi

