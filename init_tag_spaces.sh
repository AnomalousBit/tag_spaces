#!/bin/bash
source $HOME/.config/herbstluftwm/tag_spaces/tag_spaces.conf

# tag space specific keybinds
hc keybind $Mod-slash spawn "$HOME/.config/herbstluftwm/tag_spaces/switch_tag_space.sh" tag_space_1
hc keybind $Mod-Shift-slash spawn "$HOME/.config/herbstluftwm/tag_spaces/switch_tag_space.sh" tag_space_1 move

hc keybind $Mod-backslash spawn "$HOME/.config/herbstluftwm/tag_spaces/switch_tag_space.sh" tag_space_2
hc keybind $Mod-Shift-backslash spawn "$HOME/.config/herbstluftwm/tag_spaces/switch_tag_space.sh" tag_space_2 move

hc keybind Mod1-Control-Right spawn "$HOME/.config/herbstluftwm/tag_spaces/switch_tag_space_by_index.sh" +1
hc keybind Mod1-Control-Shift-Right spawn "$HOME/.config/herbstluftwm/tag_spaces/switch_tag_space_by_index.sh" +1 move

hc keybind Mod1-Control-Left spawn "$HOME/.config/herbstluftwm/tag_spaces/switch_tag_space_by_index.sh" -1
hc keybind Mod1-Control-Shift-Left spawn "$HOME/.config/herbstluftwm/tag_spaces/switch_tag_space_by_index.sh" -1 move

# used for tracking the current tag_space, so it can be toggled back to default.
hc new_attr string my_active_tag_space 2> /dev/null

#create new tags used in tag spaces
non_default_tag_spaces=(${tag_spaces[@]:1})

for tag_space in "${non_default_tag_spaces[@]}"
do
	for i in "${!tag_names[@]}"
	do
		hc add "${tag_space}_${tag_names[$i]}"
	done
done

