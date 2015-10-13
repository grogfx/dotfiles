#!/bin/bash

set -e

dir=$1

if [ ! -d $dir ]
then
	echo "Please show me where to start"
	exit 1
fi

find $dir -type f -name '*.c' -o \
 -name '*.h' -o \
 -name '*.cc' -o \
 -name '*.cpp' -o \
 -name '*.hh' -o \
 -name '*.hpp' | sort > cscope.files

cscope -q -R -b -i cscope.files 
ctags -L 'cscope.files' 
