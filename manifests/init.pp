# Class: colorprompt
#
# This module manages the /etc/profile.d/colorprompt.sh file using a template
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#  include colorprompt
#
class colorprompt (
  $default_usercolor = $colorprompt::params::default_usercolor,
  $custom_usercolors = $colorprompt::params::custom_usercolors,
  $server_color      = $colorprompt::params::server_color,
  $env_name          = $colorprompt::params::env_name,
  $env_color         = $colorprompt::params::env_color,
  $enable            = $colorprompt::params::enable,
) inherits colorprompt::params {

  validate_array($default_usercolor)
  validate_hash($custom_usercolors)
  validate_array($server_color)
  validate_string($env_name)
  validate_array($env_color)
  validate_bool($enable)

  class { '::colorprompt::template': }

}
