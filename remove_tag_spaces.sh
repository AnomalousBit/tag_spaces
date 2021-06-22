# Use this script to remove the tags created by create_tag_spaces, if you should need to start over.
# $tag_names should match those found in your herbstluftwm autostart file.

source $HOME/.config/herbstluftwm/tag_spaces/tag_spaces.conf

#create new tags used in tag spaces
non_default_tag_spaces=(${tag_spaces[@]:1})

for tag_space in "${non_default_tag_spaces[@]}"
do
	for i in "${!tag_names[@]}"
	do
		hc merge_tag "${tag_space}_${tag_names[$i]}"
	done
done
