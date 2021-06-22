#!/bin/bash
source $HOME/.config/herbstluftwm/tag_spaces/tag_spaces.conf

##################
# find new index #
##################

active_tag_space=$(hc get_attr my_active_tag_space)
number_of_tag_spaces="${#tag_spaces[*]}"
last_index_of_tag_spaces=$(( $number_of_tag_spaces - 1))
requested_index=$1
current_index=$(get_tag_space_focus_index)

new_index=0
if [[ $requested_index =~ ^[-+]?[0-9]+$ ]]
then
	if [[ "${requested_index:0:1}" == - ]]
	then
		new_index=$(($current_index + $requested_index))
	elif [[ "${requested_index:0:1}" == + ]]
	then
		new_index=$(( $current_index + ${requested_index:1}))
	else
		new_index=$requested_index
	fi
else
	echo "Invalid first argument: $1"
	echo "\n"
	echo "The first argument should be the index of the tag_space to switch to (ex: 0) or "
	echo "the relative number of tag_space elements to move from the current (ex: +3 or -2)"
	return 1
fi

# handle new_index when out of array bounds
smallest_allowable_index=$(($last_index_of_tag_spaces * -1))
if [[ $new_index -lt $smallest_allowable_index ]] || [[ $new_index -gt $last_index_of_tag_spaces ]]
then
	new_index=$(($new_index % $number_of_tag_spaces))
fi

# determine tag_prefix
requested_tag_space=${tag_spaces[$new_index]}
tag_prefix="" # no prefix is used for the default tag space
if [[ $requested_tag_space != "default" ]]; then tag_prefix="${requested_tag_space}_" ; fi

# update keybinds
for i in "${!tag_names[@]}" ; do
	key="${tag_keys[$i]}"
	if ! [ -z "$key" ] ; then
		hc keybind "$Mod-$key" use "${tag_prefix}${i}"
		hc keybind "$Mod-Shift-$key" move "${tag_prefix}${i}"
	fi
done

#######################
# switch to new index #
#######################

current_monitor=$(hc get_attr monitors.focus.index)
monitor_count=$(hc get_attr monitors.count)

hc set_attr my_active_tag_space $requested_tag_space

if [[ $2 == "move" ]]
then
	move_window_to_tag=$(($current_monitor + 1))
	hc move ${tag_prefix}${move_window_to_tag}
fi

for (( monitor=0; monitor<$monitor_count; monitor++ ))
do
	hc focus_monitor $monitor
	tag_number=$(($monitor + 1))
	hc use ${tag_prefix}${tag_number}
done
hc focus_monitor $current_monitor
