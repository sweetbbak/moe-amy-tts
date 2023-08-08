#!/bin/bash

tt() {
    printf "%s\n" "$1"
}

ydialogue() {
    # yad --form --field=Text:TXT
    yad --form --field=text:TXT --center --borders=20 \
    --title="YAD Custom Dialog Buttons" \
    --button="Browser":tt \
    --button="Announce":"bash -c announce" \
    --button="Exit"
}
ydialogue
