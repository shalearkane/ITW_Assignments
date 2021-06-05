#!/bin/bash
source helper_func.sh
source colours.sh

search_file() {
    local file_path
    local pattern
    read -p "Enter the filename: " file_path
    read -p "Enter the pattern to be searched for: " pattern
    for l in $file_path; do
        if file "$l" | grep -q text; then
            flag=1
            if grep -Eq "$pattern" "$l"; then
                grep -HEns "$pattern" "$l" | less -r --prompt="Press q to exit"
            else
                echo -e "${RED}error: $l has no matching text${ENDCOLOUR}" | less -r
            fi
        fi
    done

    if [[ $flag != 1 ]]; then
        echo -e "${RED}File not found${ENDCOLOUR}"
    fi

    read -n 1 -r -s -p $'\nPress any key to continue... '
    clear
}

count_wc() {
    local file_path
    local flag
    local lines
    local words
    local chars
    read -p "Enter the path of the file: " file_path

    for l in $file_path; do
        if file "$l" | grep -q text; then
            flag=1
            lines="${COLOUR}$(wc -l $l | cut -d " " -f1)${ENDCOLOUR}"
            words="${COLOUR}$(wc -w $l | cut -d " " -f1)${ENDCOLOUR}"
            chars="${COLOUR}$(wc -m $l | cut -d " " -f1)${ENDCOLOUR}"
            echo -e "$l has $lines lines, $words words and $chars characters.\n" | less -r --prompt="Press q to exit"
        fi
    done

    if [[ $flag != 1 ]]; then
        echo -e "${RED}File not found${ENDCOLOUR}"
    fi

    read -n 1 -r -s -p $'\nPress any key to continue... '
    clear
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

    diff --color -y $file_1 $file_2 | less -r --prompt="Press q to exit"
    clear
}

text_processing_menu() {
    local selection
    until [ "$selection" = "0" ]; do
        center_text "${BGCOLOUR}TEXT MENU${ENDCOLOUR}" " "
        echo -e "\n${COLOUR}1${ENDCOLOUR} -- Search a file for a pattern"
        echo -e "\n${COLOUR}2${ENDCOLOUR} -- Count lines, words, and characters in specified files"
        echo -e "\n${COLOUR}3${ENDCOLOUR} -- Display line differences between two files"

        if [ $MYHELP_MODE = novice ]; then
            echo -e "\n${COLOUR}4${ENDCOLOUR} -- Quit -- Return to main Menu"
        else
            echo -e "\n${COLOUR}4${ENDCOLOUR} -- Quit -- Exit Program"
        fi

        center_text_prompt "\b\b\b\b\b\b\bEnter your choice: " " "
        read -n 1 -r selection
        clear
        case $selection in
        1)
            search_file
            ;;
        2)
            count_wc
            ;;
        3)
            display_diff
            ;;
        q | 4)
            exit 0
            ;;
        *)
            center_text "${RED}error: Enter correct choice [1-5]${ENDCOLOUR}"
            selection=
            ;;
        esac
    done
}

text_processing_menu
