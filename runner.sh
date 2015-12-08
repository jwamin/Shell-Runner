#!/bin/bash
# ------------------------------------------------------------------
# [Author] Title
#          Description
# ------------------------------------------------------------------

# task runner REQUIREMENTS
# 
# JAVASCRIPT
# transpiles es6 code to es5 via babel, concats and includes javascript modules and frameworks, minifys for distribution
# includes modernizr for dist build
# 
# CSS
# Compiles SCSS to CSS, 
# 
# 
# dist minifies js and css 


SUBJECT=some-unique-id
VERSION=0.1.0
USAGE="Usage: command -hv args"

# --- Option processing --------------------------------------------
if [ $# == 0 ] ; then
    echo $USAGE
    exit 1;
fi

while getopts ":vh" optname
  do
    case "$optname" in
      "v")
        echo "Version $VERSION"
        exit 0;
        ;;
      "h")
        echo $USAGE
        exit 0;
        ;;
      "?")
        echo "Unknown option $OPTARG"
        exit 0;
        ;;
      ":")
        echo "No argument value for option $OPTARG"
        exit 0;
        ;;
      *)
        echo "Unknown error while processing options"
        exit 0;
        ;;
    esac
  done

shift $(($OPTIND - 1))

source ./functions.sh

param1=$1
param2=$2
# -----------------------------------------------------------------

LOCK_FILE=/tmp/${SUBJECT}.lock

if [ -f "$LOCK_FILE" ]; then
echo "Script is already running"
exit
fi

scriptCleanup () {
  cleanUp
  bash -c "rm -f $LOCK_FILE"
}

# -----------------------------------------------------------------
trap scriptCleanup EXIT
touch $LOCK_FILE 

# -----------------------------------------------------------------
#  SCRIPT LOGIC GOES HERE
# -----------------------------------------------------------------

#say "for the third time, peter is the strongest link, whilst james is the weakest link"

# echo "param1:" $param1
# echo "param2:" $param2


if [ $param1 = "build" ]; then
  echo "running build task"
  dest=./build
  build
elif [ $param1 = "watch" ]; then
  echo "starting watch task"
  dest=./build
  watch
elif [ $param1 = "dist" ]; then
  echo "compiling for dist"
  dest=./dist
  dist
else echo "please enter build or dist" && exit 1;
fi

exit 0;
