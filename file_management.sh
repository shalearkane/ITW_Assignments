#!/bin/bash
# this one supports wildcards

source helper_func.sh
source colours.sh

display_contents_of_file() {
    local file_path
    local flag
    read -p "Enter the path of the file: " file_path
    for f in $file_path; do
        if [[ -f "$f" ]]; then
            flag=1
            echo -e "${COLOUR}The contents of $f is:${ENDCOLOUR} \n $(cat $f)" | less -r
        fi
    done

    if [[ $flag != 1 ]]; then
        echo -e "${RED}File not found${ENDCOLOUR}"
    fi

    read -n 1 -r -s -p $'Press enter to continue...\n'
}

remove_file() {
    local file_path
    local flag
    read -p "Enter the path of the file: " file_path
    for r in $file_path; do
        if [[ -f "$r" ]]; then
            flag=1
            rm $r
            echo -e "Deleted $r\n"
        fi
    done

    if [[ $flag != 1 ]]; then
        echo -e "${RED}File not found${ENDCOLOUR}"
    fi

    read -n 1 -r -s -p $'Press enter to continue...\n'
}

copy_file() {
    local flag
    local file_path
    local file_copy_location
    read -p "Enter the path of the file: " file_path
    read -p "Enter the path of the directory to copy: " file_copy_location
    for c in $file_path; do
        if [[ -f "$c" && -d "$file_copy_location" ]]; then
            flag=1
            cp -t "$file_copy_location" "$file_path"
            echo -e "Copied $c to $file_copy_location\n"
        fi
    done

    if [[ $flag != 1 ]]; then
        echo -e "${RED}File not found${ENDCOLOUR}"
    fi

    read -n 1 -r -s -p $'Press enter to continue...\n'
}

list_file() {
    local file_path
    local flag
    read -p "Enter the path of the file: " file_path

    for l in $file_path; do
        if [[ -d "$l" ]]; then
            flag=1
            echo -e "${COLOUR}The contents of $f is:${ENDCOLOUR} \n $(ls $l)" | less -r
        fi
    done

    if [[ $flag != 1 ]]; then
        echo -e "${RED}File not found${ENDCOLOUR}"
    fi

    read -n 1 -r -s -p $'Press enter to continue...\n'
}

size_of_file() {
    local file_path
    local flag
    read -p "Enter the path of the file: " file_path

    for s in $file_path; do
        if [[ -f "$s" ]]; then
            flag=1
            du -h "$s" | cut -f1
        fi
    done

    if [[ $flag != 1 ]]; then
        echo -e "${RED}File not found${ENDCOLOUR}"
    fi

    
}

file_management_menu() {
    local selection
    until [ "$selection" = "0" ]; do
        clear
        echo -e "\n${COLOUR}1${ENDCOLOUR} -- Display the contents of a file"
        echo -e "\n${COLOUR}2${ENDCOLOUR} -- Remove a file"
        echo -e "\n${COLOUR}3${ENDCOLOUR} -- Copy a file"
        echo -e "\n${COLOUR}4${ENDCOLOUR} -- List a file"
        echo -e "\n${COLOUR}5${ENDCOLOUR} -- Size of a file"
        if [ $MYHELP_MODE = novice ]; then
            echo -e "\n${COLOUR}6${ENDCOLOUR} -- Quit -- Return to main Menu"
        else
            echo -e "\n${COLOUR}6${ENDCOLOUR} -- Exit Program"
        fi

        center_text_prompt "\b\bEnter your choice: " " "
        read selection
        case $selection in
        1)
            clear
            display_contents_of_file
            ;;
        2)
            clear
            remove_file
            ;;
        3)
            clear
            copy_file
            ;;
        4)
            clear
            list_file
            ;;
        5)
            clear
            size_of_file
            ;;
        6)
            clear
            exit 0
            ;;
        *)
            clear
            echo -e "${RED}enter something useful${ENDCOLOUR}"
            ;;
        esac
    done
}

file_management_menu
