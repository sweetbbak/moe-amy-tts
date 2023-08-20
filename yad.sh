#! /bin/bash

# YAD form/btn example
# update form field contents via button 

function on_click () {
    for FIELDNR in {1..3}; do
      echo "$FIELDNR:Loading next item..."
    done
    sleep 2
    for FIELDNR in {1..3}; do
      echo "$FIELDNR:Updated Field $FIELDNR"
    done
}
export -f on_click

yad \
--form \
--field="Field 1:" \
--field="Field 2:" \
--field="Field 3:" \
--field "Next:BTN" \
"Field 1 content" \
"Field 2 content" \
"Field 3 content" \
"@bash -c on_click"
