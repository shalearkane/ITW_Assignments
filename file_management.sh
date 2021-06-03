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
            if [[ -r "$f" ]]; then
                echo -e "${COLOUR}The contents of $f is:${ENDCOLOUR} \n $(cat $f)" | less -r --prompt="Press q to exit"
            else
                echo -e "${RED}The file is not readable${ENDCOLOUR}"
            fi
        fi
    done

    if [[ $flag != 1 ]]; then
        echo -e "${RED}File not found${ENDCOLOUR}"
    fi

    read -n 1 -r -s -p $'Press any key to continue...\n'
    clear
}

remove_file() {
    local file_path
    local flag
    read -p "Enter the path of the file: " file_path
    for r in $file_path; do
        if [[ -f "$r" ]]; then
            flag=1
            if rm $r; then
                echo -e "Deleted $r\n"
            else
                echo -e "${RED}error: while deleting${ENDCOLOUR}"
            fi
        fi
    done

    if [[ $flag != 1 ]]; then
        echo -e "${RED}File not found${ENDCOLOUR}"
    fi

    read -n 1 -r -s -p $'Press any key to continue...\n'
    clear
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
            if cp -t "$file_copy_location" "$file_path"; then
                echo -e "Copied $c to $file_copy_location\n"
            else
                echo -e "${RED}error: while copying${ENDCOLOUR}"
            fi
        fi
    done

    if [[ $flag != 1 ]]; then
        echo -e "${RED}File not found${ENDCOLOUR}"
    fi

    read -n 1 -r -s -p $'Press any key to continue...\n'
    clear
}

list_file() {
    local file_path
    local flag
    read -p "Enter the path of the file: " file_path

    for l in $file_path; do
        if [[ -d "$l" ]]; then
            flag=1
            echo -e "${COLOUR}The contents of $l is:${ENDCOLOUR}\n$(ls $l)" | less -r --prompt="Press q to exit"
        fi
    done

    if [[ $flag != 1 ]]; then
        echo -e "${RED}File not found${ENDCOLOUR}"
    fi

    read -n 1 -r -s -p $'Press any key to continue...\n'
    clear
}

size_of_file() {
    local file_path
    local flag
    read -p "Enter the path of the file: " file_path

    for s in $file_path; do
        if [[ -d "$s" ]]; then
            echo -e "${RED}error: $s is a directory, skipping...${ENDCOLOUR}"
            continue
        fi
        if [[ -f "$s" ]]; then
            flag=1
            if du -h "$s" | cut -f1; then
                echo
            else
                echo "The size of file cannot be shown"
            fi
        fi
    done

    if [[ $flag != 1 && ! -d "$s" ]]; then
        echo -e "${RED}File not found${ENDCOLOUR}"
    fi
    read -n 1 -r -s -p $'Press any key to continue...\n'
    clear
}

file_management_menu() {
    local selection
    until [ "$selection" = "0" ]; do
        echo -e "${COLOUR}1${ENDCOLOUR} -- Display the contents of a file"
        echo -e "${COLOUR}2${ENDCOLOUR} -- Remove a file"
        echo -e "${COLOUR}3${ENDCOLOUR} -- Copy a file"
        echo -e "${COLOUR}4${ENDCOLOUR} -- List a file"
        echo -e "${COLOUR}5${ENDCOLOUR} -- Size of a file"
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
        q | 6)
            clear
            exit 0
            ;;
        *)
            clear
            center_text "${RED}error: Enter correct choice [1-6]${ENDCOLOUR}"
            ;;
        esac
    done
}

file_management_menu
