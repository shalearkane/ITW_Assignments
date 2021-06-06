#!/bin/bash

source helper_func.sh
source colours.sh

unix_help_main_menu() {
    local selection
    until [ "$selection" = "0" ]; do
        center_text "${BGCOLOUR}MAIN MENU${ENDCOLOUR}" " "
        echo -e "${COLOUR}1${ENDCOLOUR} -- File and Directory Management Commands"
        echo -e "${COLOUR}2${ENDCOLOUR} -- Text Processing Commands"
        echo -e "${COLOUR}3${ENDCOLOUR} -- System Status Commands"
        echo -e "${COLOUR}4${ENDCOLOUR} -- Exit\n"
        center_text_prompt "\b\b\b\b\b\b\bEnter your choice: " " "
        read -n 1 -r selection
        clear
        case $selection in
        1)
            bash file_management.sh
            ;;
        2)
            bash text_processing.sh
            ;;
        3)
            bash system_status.sh
            ;;
        q | 4)
            exit 0
            ;;
        *)
            center_text "${RED}error: Enter correct choice [1-4]${ENDCOLOUR}"
            selection=
            ;;
        esac
    done

}

expert_menu() {
    clear
    case "$1" in
    help)
        bash help.sh
        ;;
    file)
        bash file_management.sh
        ;;
    text)
        bash text_processing.sh
        ;;
    status)
        bash system_status.sh
        ;;
    author)
        echo "Soumik Dutta"
        ;;
    *)
        center_text "${RED}error: Enter correct argument [file, text, status, help] ... see help for details.${ENDCOLOUR}"
        ;;
    esac
}

clear
if (($# == 0)); then
    export MYHELP_MODE=novice
    export COLOUR=$GREEN
    export BGCOLOUR=$GREENBG
    unix_help_main_menu
else
    export MYHELP_MODE=expert
    export COLOUR=$BLUE
    export BGCOLOUR=$BLUEBG
    expert_menu "$1"
fi
