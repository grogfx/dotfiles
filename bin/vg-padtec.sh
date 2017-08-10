#!/bin/sh

valgrind --tool=memcheck --suppressions=/home/gmartins/tools/scripts/valgrind-padtec.supp --gen-suppressions=all --leak-check=full --show-leak-kinds=all --track-origins=yes $@
