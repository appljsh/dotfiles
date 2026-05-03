#!/bin/sh

MUTE_STATUS=$(pactl get-source-mute @DEFAULT_SOURCE@ | grep -n 'yes'| awk '{print $2}')

if [ "$MUTE_STATUS" = "yes" ]; then
  echo "" 
else
  echo ""
fi
