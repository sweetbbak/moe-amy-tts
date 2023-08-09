#!/bin/bash

rate=1

show_version() {
    echo -e "${0##*/} version ${version}"
}

print_help() {
    echo -e "${0##*/}"
    # echo -e "\t-f\tinput file"
    echo -e "\t-t\tText"
    echo -e "\t-g\tUse GUI"
    # echo -e "\t-r\trate"
    echo -e "\t-V\tShow Version"
    echo -e "\t-h\tPrint help"
}

file_location() {
     FILE=$(zenity --entry \
       --width 500 \
       --title "check user" \
       --text "Enter File Path: ")
}


tts() {
    echo "${@}" \
        | piper --length_scale "${rate}" --model /app/ivona/amy.onnx --output_raw \
        | pacat --rate=22050 --format=s16le --channels=1 --raw
}

tts2file() {
    output="${1:-$HOME/Documents/output.wav}" ; shift
    echo "${@}" \
        | piper --length_scale "${rate}" --model /app/ivona/amy.onnx -f "${output}"
}

dialogue() {
    text="$(zenity --text-info \
        --title='Amy - text-to-speech' \
        --editable \
        --width=500 \
        --height=250
    )"
    text="$(echo "${text}" |sed 's/[^[:print:]]//')"

    [ -n "$text" ] && tts "${text}"
}

file_dialogue() {
    info="$(
    zenity --forms --add-entry="Input File" \
        --text="Amy TTS" --width=500 --height=300 \
        --add-entry="Output File" 
        # --add-combo=Rate --combo-values="1.5|1|.5" \
        # --add-list=Rate --list-values="1.5|1|.5"
    )"

    file1="$(echo "$info" | cut -d --delimiter="|" --fields=1)"
    file2="$(echo "$info" | cut -d --delimiter="|" --fields=2)"
    # lrate="$(echo "$info" | cut -d --delimiter="|" --fields=3)"
    [ -f "$file1" ] && if file "$file1" | grep "text" ; then text="$(cat "$file1")"; fi
    [ -n "$file2" ] && ext="${file2##*.}" ; if [ "${ext}" = ".wav" ]; then echo ; else file2="${file2}.wav" ; fi
    # [ -n "$lrate" ] && rate="$lrate" || rate="$rate"

    tts2file "${file2}" "${text}"
    
}

if [ $# -eq 0 ]; then
    dialogue
    exit
fi

while [ $# -gt 0 ]; do
    case "$1" in
        -h|--help) ;;
        -V|--version) show_version && exit 0 ;;
        -r|--rate) shift && rate="$1" ;;
        -f|--file) file_dialogue ;;
        -t|--text) shift && tts "${@}" ; exit 0 ;;
        -g|--gui) dialogue ;;
        -o|--output) shift && tts2file "${1}" "${2}" ;;
        *) dialogue ;;

    esac
    shift
done

