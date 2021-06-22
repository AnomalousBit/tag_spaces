#!/bin/bash
source $HOME/.config/herbstluftwm/tag_spaces/tag_spaces.conf

# update active_tag_space
active_tag_space=`hc get_attr my_active_tag_space`
requested_tag_space="${1:-tag_space_1}"

if [[ $active_tag_space == $requested_tag_space ]]
then # toggle back to default if the active matches the requested tag space
	hc set_attr my_active_tag_space "default"
	active_tag_space=default
else
	hc set_attr my_active_tag_space $requested_tag_space
	active_tag_space=$requested_tag_space
fi

# update keybinds
for i in "${!tag_names[@]}" ; do
	key="${tag_keys[$i]}"
	if ! [ -z "$key" ] ; then
		hc keybind "$Mod-$key" use "${tag_prefix}${i}"
		hc keybind "$Mod-Shift-$key" move "${tag_prefix}${i}"
	fi
done

# switch to new index
tag_prefix=""
if [[ $active_tag_space != "default" ]] ; then tag_prefix="${active_tag_space}_" ; fi

current_monitor=`hc get_attr monitors.focus.index`
monitor_count=`hc get_attr monitors.count`

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
