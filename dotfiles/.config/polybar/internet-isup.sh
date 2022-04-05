#!/bin/sh

output=$(ping -q -c 2 1.1.1.1 2> /dev/null)
rc=$?
if [[ $rc -eq 0 ]]; then
    # Internet is Up
    echo "%{F#08fee4} %{F-}"
else
    # Internet is down
    echo "%{F#daa520} %{F-}"
fi
