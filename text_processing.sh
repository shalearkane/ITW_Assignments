#!/bin/bash
source helper_func.sh
source colours.sh

search_file() {
    local file_name
    read -p "Enter the filename: " file_name
    find ~/ -type f -name "$file_name" | less
    read -n 1 -r -s -p $'Press any key to continue...\n'
}

count_wc() {
    local file_path
    local flag
    read -p "Enter the path of the file: " file_path

    for l in $file_path; do
        if file "$l" | grep -q text; then
            flag=1
            echo -e "${COLOUR}The count of lines, words, and characters in $l is:${ENDCOLOUR} \n $(wc $l)" | less -r
        fi
    done

    if [[ $flag != 1 ]]; then
        echo -e "${RED}File not found${ENDCOLOUR}"
    fi

    read -n 1 -r -s -p $'Press any key to continue...\n'
}

display_diff() {
    local file_1
    local file_2

    while true; do
        local i=0
        read -p "Enter the path of the first file: " file_1

        for l in $file_1; do
            i=$((i + 1))
        done
        if [[ $i -ne 1 ]]; then
            echo -e "${RED}You've entered wrong filename or more than one file${ENDCOLOUR}"
            continue
        fi

        if file "$file_1" | grep -q text; then
            break
        else
            echo -e "${RED}error: The file is not a text file or cannot be found${ENDCOLOUR}"
        fi
    done

    while true; do
        local i=0
        read -p "Enter the path of the second file: " file_2
        for l in $file_2; do
            i=$((i + 1))
        done
        if [[ $i -ne 1 ]]; then
            echo -e "${RED}error: You've entered wrong filename or more than one file${ENDCOLOUR}"
            continue
        fi

        if file "$file_2" | grep -q text; then
            break
        else
            echo -e "${RED}error: The file is not a text file or cannot be found${ENDCOLOUR}"
        fi
    done

    diff -y $file_1 $file_2 | less
}

text_processing_menu() {
    local selection
    until [ "$selection" = "0" ]; do
        clear
        echo -e "\n${COLOUR}1${ENDCOLOUR} -- Search a file for a pattern"
        echo -e "\n${COLOUR}2${ENDCOLOUR} -- Count lines, words, and characters in specified files"
        echo -e "\n${COLOUR}3${ENDCOLOUR} -- Display line differences between two files"

        if [ $MYHELP_MODE = novice ]; then
            echo -e "\n${COLOUR}4${ENDCOLOUR} -- Quit -- Return to main Menu"
        else
            echo -e "\n${COLOUR}4${ENDCOLOUR} -- Quit -- Exit Program"
        fi

        center_text_prompt "\b\bEnter your choice: " " "
        read selection
        case $selection in
        1)
            clear
            search_file
            ;;
        2)
            clear
            count_wc
            ;;
        3)
            clear
            display_diff
            ;;
        4)
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

text_processing_menu
