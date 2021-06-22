# tag_spaces
tag_spaces is an extension to herbstluftwm that adds a new concept called tag spaces.

A Tag Space is a group of tags along with keybindings that only operate on the currently selected tag space.

The current / active tag space is selected by using keybinds and can be specified by name, relative or cardinal array index.

By switching to a new tag space, the default Mod+[0-9] keybinds are remapped to the selected tag space and it's first N tags are automatically displayed on your first N monitors.

# Installation

First, get the extension's files:

`git clone https://github.com/AnomalousBit/tag_spaces $HOME/.config/herbstluftwm/tag_spaces`

Make any changes you wish inside of `tag_spaces/tag_spaces.conf`

Adjust the keybinds in `tag_spaces/init_tag_spaces.sh`.

Then at last, call the initialization script inside of your herbstluftwm `autostart` script:

```
#create and keybind tag_spaces
source $HOME/.config/herbstluftwm/tag_spaces/init_tag_spaces.sh
```

# Why tag_spaces?

Having a long running history with other WMs like Gnome, Cinnamon and KDE Plasma, I'm a big fan of the traditional Ctrl-Alt-[left/right] and Ctrl-Alt-Shift-[left/right] to navigate and move windows between virtual desktops, updating multiple monitors at once. This extension recreates that feel, along with a new set of 0-9 tags for each tag space. It's like having multiple instances of herbstluftwm in a way.

There are also default keybinds for Mod+slash and Mod+backslash for navigating to a specific tag_space and toggling back to the default un-tag_spaced tags.

# Script Functionality

## switch_tag_space.sh
This script will allow you to navigate and move between tag_spaces using:
* The tag_space name (first argument, optional)
* Move focused window (second argument as "move", optional)

```
# switch to tag_space_1
./switch_tag_space.sh tag_space_1

# moves the current focused window (focused monitor aware) and switches to tag_space_1
./switch_tag_space.sh tag_space_1 move
```

## switch_tag_space_by_index.sh
This script will allow you to navigate and move between tag_spaces using:
* The relative index (+1, -2) or absolute index (0, 1, 2, 3...) of the tag_spaces array (first argument, required)
* Move focused window (second argument as 'move', optional)

```
# switch to the next tag_space
./switch_tag_space_by_index.sh +1

# switch to the next tag_space and move the currently focused window
./switch_tag_space_by_index.sh +1 move

# switch to the previous tag_space
./switch_tag_space_by_index.sh -1

# switch to the first tag_space in the tag_spaces array (defined in tag_spaces.conf)
./switch_tag_space_by_index 0
```

