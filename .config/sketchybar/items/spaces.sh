#!/bin/sh

SPACE_ICONS=("1" "2" "3" "4" "5" "6" "7" "8" "9" "10" "11" "12" "13" "14" "15")

# Destroy space on right click, focus space on left click.
# New space by left clicking separator (>)

sid=0
spaces=()
for i in "${!SPACE_ICONS[@]}"
do
  sid=$(($i+1))
  sketchybar --add space      space.$sid left                               \
             --set space.$sid associated_space=$sid                         \
                              icon=${SPACE_ICONS[i]}                        \
                              icon.padding_left=10                          \
                              icon.padding_right=10                         \
                              padding_left=2                                \
                              padding_right=4                               \
                              label.padding_right=20                        \
                              label.font="sketchybar-app-font:Regular:16.0" \
                              label.background.height=26                    \
                              label.background.drawing=on                  \
                              label.background.corner_radius=8              \
                              label.drawing=off                            \
                              script="$PLUGIN_DIR/space.sh"                 \
            --subscribe       space.$sid mouse.clicked
done

sketchybar --add bracket spaces '/space\..*/'                  \
           --set spaces  background.color=$BLACK        \
                         background.border_color=$BLACK \
                         background.border_width=2             \
                         background.drawing=on        \


sketchybar   --add item       separator left                                  \
             --set separator  icon=$YABAI_NEW_WINDOW                                         \
                              icon.font="Hack Nerd Font:Regular:16.0"         \
                              padding_left=17                                 \
                              padding_right=10                                \
                              label.drawing=off                                \
                              associated_display=active                       \
                              click_script='yabai -m space --create
                                            sketchybar --trigger space_change
                                            sketchybar --trigger windows_on_spaces'\
                              icon.color=$YELLOW \
 

