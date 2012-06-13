#!/bin/bash
############################################################
# Linux CPU Usage Monitor                                  #
#                                                          #
# Author: Moises P. Sena (http://moisespsena.com)          #
# Original Author: Paul Colby (http://colby.id.au)         #
#                                                          #
# no rights reserved :)                                    #
############################################################

PREV_TOTAL=0
PREV_IDLE=0

_s=0
_f=0
_l=0

do_cmd() {
  local CPU=(`cat /proc/stat | grep '^cpu '`) # Get the total CPU statistics.
  unset CPU[0]                                # Discard the "cpu" prefix.
  local IDLE=${CPU[4]}                        # Get the idle CPU time.

  # Calculate the total CPU time.
  local TOTAL=0
  for VALUE in "${CPU[@]}"; do
    let "TOTAL=$TOTAL+$VALUE"
  done

  # Calculate the CPU usage since we last checked.
  let "DIFF_IDLE=$IDLE-$PREV_IDLE"
  let "DIFF_TOTAL=$TOTAL-$PREV_TOTAL"
  let "DIFF_USAGE=(1000*($DIFF_TOTAL-$DIFF_IDLE)/$DIFF_TOTAL+5)/10"

  if [ $_l = 1 ]
  then
    if [ $_s = 1 ]; then
        echo -en "\r$DIFF_USAGE  \b\b"
    else
        echo -en "\rCPU: $DIFF_USAGE%  \b\b"
    fi
  elif [ $_s = 1 ]; then
    echo "$DIFF_USAGE"
  else
    echo "CPU: $DIFF_USAGE%"
  fi

  # Remember the total and idle CPU times for the next check.
  PREV_TOTAL="$TOTAL"
  PREV_IDLE="$IDLE"
}

do_help() {
   cat <<EOF
Linux CPU Usage Monitor
 
  Author: Moises P. Sena (http://moisespsena.com)
  Original Author: Paul Colby (http://colby.id.au)
 
Usage $0 [-l [-s|-f] |-h]

Options

  -h: Print this messsage

  -s: Print the percent number. Example: 10

  -f: Print the formated percent number. Example: CPU: 10%

  -l: Print with infinit loop

Examples:

  $0 -s
  $0 -f
  $0 -l -s
  $0 -l -f
  $0 -h
EOF
}

do_error() {
    do_help 1>2
    exit 1
}

while getopts "sflh" op; do
    case "$op" in
        s) _s=1
            ;;
        f) _f=1
            ;;
        l)  _l=1
            ;;
        h) do_help
            exit
            ;;
        *)  do_error
            ;;
    esac
done

[ "$1" = "" ] && _f=1 && _l=1

if [ $_l = 1 ]; then
    while true; do do_cmd ; sleep .5; done
else
    do_cmd
fi
