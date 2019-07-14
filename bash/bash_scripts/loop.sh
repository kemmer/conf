#!/bin/bash

# Executes a command multiple times
loopexec()
{
    TIMES="$1"
    shift; COMMAND="$@"

    for ((n=1; n <= $TIMES; n++))
    do
        ${COMMAND}
    done
}

# Executes a command multiple times using GNU Parallel (more performatic)
#loopexecp()
#{
#    TIMES="$1"
#    shift; COMMAND="$@"
#
#    parallel -N0 -j12 ${COMMAND} ::: {1..${TIMES}}
#}

