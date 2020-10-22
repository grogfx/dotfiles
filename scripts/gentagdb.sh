#!/bin/bash

HERE=$(pwd)

DIR=${1:-"${HERE}"}

CSCOPE_FILES="${HERE}/cscope"

if [[ ! -d ${CSCOPE_FILES} ]]; then
  mkdir "${CSCOPE_FILES}"
fi

find "$DIR" -name "*.c" -o \
-name "*.cc" -o \
-name "*.cpp" -o \
-name "*.h" -o \
-name "*.hh" -o \
-name "*.hpp" \
-type f > "${CSCOPE_FILES}"/cscope.files

cd "${CSCOPE_FILES}"
cscope -q -R -b -k
ctags -L 'cscope.files'
cd "${DIR}"
