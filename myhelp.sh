#!/bin/bash

# shellcheck source=helper_func.sh
source helper_func.sh
source colours.sh

unix_help_main_menu() {
    local selection
    until [ "$selection" = "0" ]; do
        clear
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
        4)
            clear
            exit 0
            ;;
        *)
            clear
            echo -e "\n${RED}Enter correct input\n${ENDCOLOUR}"
            ;;
        esac
    done

}

expert_menu() {
    case "$1" in
    help)
        echo "Help is not available at the moment, but you can always help yourself"
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
    *)
        clear
        echo -e "\n${RED}Enter correct input\n${ENDCOLOUR}"
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

echo -e "Script exited\n"
