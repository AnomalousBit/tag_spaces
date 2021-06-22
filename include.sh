#!/bin/bash

# this file contains reusable variables and functions across the other tag space scripts
hc() {
    herbstclient "$@"
}

get_tag_space_focus_index() {
	if [ -z "$active_tag_space" ]
	then
		echo -1
		return
	fi
		
	for i in "${!tag_spaces[@]}"
	do
		if [[ "${tag_spaces[$i]}" == $active_tag_space ]]
		then
			echo $i
			break
		fi
	done
}

