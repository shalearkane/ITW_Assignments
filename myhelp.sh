#!/bin/bash

source helper_func.sh
source colours.sh

unix_help_main_menu() {
    local selection
    until [ "$selection" = "0" ]; do
        echo -e "\n${COLOUR}1${ENDCOLOUR} -- File and Directory Management Commands"
        echo -e "\n${COLOUR}2${ENDCOLOUR} -- Text Processing Commands"
        echo -e "\n${COLOUR}3${ENDCOLOUR} -- System Status Commands"
        echo -e "\n${COLOUR}4${ENDCOLOUR} -- Exit\n"
        center_text_prompt "\b\bEnter your choice: " " "
        read selection
        case $selection in
        1)
            clear
            bash file_management.sh
            ;;
        2)
            clear
            bash text_processing.sh
            ;;
        3)
            clear
            bash system_status.sh
            ;;
        q | 4)
            clear
            exit 0
            ;;
        *)
            clear
            center_text "${RED}error: Enter correct choice [1-4] ... ${ENDCOLOUR}"
            ;;
        esac
    done

}

expert_menu() {
    case "$1" in
    help)
        bash help.sh
        clear
        ;;
    file)
        clear
        bash file_management.sh
        ;;
    text)
        clear
        bash text_processing.sh
        ;;
    status)
        clear
        bash system_status.sh
        ;;
    author)
        clear
        echo "Soumik Dutta"
        ;;
    *)
        clear
        center_text "${RED}error: Enter correct argument [file, text, status, help] ... see help for details.${ENDCOLOUR}"
        ;;
    esac
}

if (($# == 0)); then
    export MYHELP_MODE=novice
    export COLOUR=$GREEN
    unix_help_main_menu
else
    export MYHELP_MODE=expert
    export COLOUR=$BLUE
    expert_menu "$1"
fi
