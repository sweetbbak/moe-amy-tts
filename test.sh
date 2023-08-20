#!/bin/bash

ttxx() {
    printf "%s\n" "$1"
}

ydialogue() {
    # yad --form --field=Text:TXT
    yad --form --field=text:TXT --center --borders=20 \
    --title="YAD Custom Dialog Buttons" \
    --button="Speak":ttxx \
    --button="Announce":"bash -c ttxx" \
    --button="Exit"
}

export -f ttxx
ydialogue
