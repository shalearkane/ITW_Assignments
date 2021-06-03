#!/bin/bash

source helper_func.sh
source colours.sh

file_t="${BLUE}file${ENDCOLOUR}"
text_t="${BLUE}text${ENDCOLOUR}"
status_t="${BLUE}status${ENDCOLOUR}"
help_t="${BLUE}help${ENDCOLOUR}"
center_text "${COLOUR}Guide to using the myhelp script${ENDCOLOUR}" " "
echo -e "There are four command line arguments: $file_t, $text_t, $status_t and $help_t"
echo -e "\n$file_t  \tperforms file management operations like display contents and size of files along with removing, copy and listing."
echo -e "      \tThis section of myhelp use the commands cat, du, rm, cp and ls for its working."
echo -e "\n$text_t  \tperforms text processing operations like searching contents, counting stats (lines, words and characters) and showing line difference of two files."
echo -e "      \tThis section of myhelp use the commands grep, wc and diff for its working."
echo -e "\n$status_t\tshows system status like current date time, disk usage, local and environmental variable and process status information"
echo -e "      \tThis section of myhelp use the commands date, df, printenv and ps for its working."
echo -e "\n$help_t  \tshows this help section."
echo -e "      \tTo update this script to the latest release, git clone ${RED}https://github.com/shalearkane/ITW_Assignments${ENDCOLOUR}"

read -n 1 -r -s -p $'Press any key to continue...\n'
clear
