#!/bin/bash
source helper_func.sh
source colours.sh

current_date() {
    while sleep 0.1; do
        local throwaway
        clear
        date
        read -t 0.5 -n 1 -r -s -p $'\nPress any key to exit...\n' throwaway
        if [ -z $throwaway ]; then
            continue
        else
            break
        fi
    done
}

disk_usage() {
    echo -e "${COLOUR}Disk usage of system is:${ENDCOLOUR} \n $(df -h)" | less -r
}

local_env_vars() {
    echo -e "The local and environment variables are: \n $(printenv)" | less -r
}

process_status_info() {
    local re='^[0-9]+$'
    read -p "Enter process id to see process status: " pid_n
    if ! [[ $pid_n =~ $re ]]; then
        echo -e "${RED}error: Not a number${ENDCOLOUR}"
    else
        ps $pid_n
    fi
    read -n 1 -r -s -p $'Press any key to continue...\n'
}

system_status_menu() {
    local selection
    until [ "$selection" = "0" ]; do
        clear
        echo -e "\n${COLOUR}1${ENDCOLOUR} -- Display the current date and time"
        echo -e "\n${COLOUR}2${ENDCOLOUR} -- Current disk usage"
        echo -e "\n${COLOUR}3${ENDCOLOUR} -- List current local and environmental"
        echo -e "\n${COLOUR}4${ENDCOLOUR} -- Display process status information"

        if [ $MYHELP_MODE = novice ]; then
            echo -e "\n${COLOUR}5${ENDCOLOUR} -- Quit -- Return to main Menu"
        else
            echo -e "\n${COLOUR}5${ENDCOLOUR} -- Quit -- Exit Program"
        fi

        center_text_prompt "Enter your choice: " " "
        read selection
        case $selection in
        1)
            clear
            current_date
            ;;
        2)
            clear
            disk_usage
            ;;
        3)
            clear
            local_env_vars
            ;;
        4)
            clear
            process_status_info
            ;;
        5)
            clear
            exit 0
            ;;
        *)
            clear
            echo "enter something useful"
            ;;
        esac
    done
}

system_status_menu
