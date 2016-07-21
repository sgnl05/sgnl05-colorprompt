# == Define: validate_colors
#
# Define for validate color values in array or string.
#
define colorprompt::validate_colors (
  $colors = $title, 
) {
  if is_string($colors) {
    unless member($fg_colors_keys, $colors) {
      fail("Color '${colors}' not found value of hash \$fg_colors in class colorprompt::params!")
    }
  } elsif is_array($colors) {
    if size($colors) == 4 {
      fail("Array of colors '${colors}' size must be 1,2 or 3 elements!")
    }
    unless member($fg_colors_keys, $colors[0]) {
      fail("Color '${colors[0]}' not found value of hash \$fg_colors in class colorprompt::params!")
    }
    if $colors[1] {
      unless member($bg_colors_keys, $colors[1]) {
        fail("Color '${colors[1]}' not found value of hash \$bg_colors in class colorprompt::params!")
      }
    }
    if $colors[2] {
      unless member($thid_colors_keys, $colors[1]) {
        fail("Color '${colors[1]}' not found value of hash \$styles in class colorprompt::params!")
      }
    }
  } else {
    fail("Colors '${colors}' array or stirng!")
  }
}
