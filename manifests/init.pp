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
#
#  class { '::colorprompt': }
#
class colorprompt (
  $default_usercolor = $colorprompt::params::default_usercolor,
  $custom_usercolors = $colorprompt::params::custom_usercolors,
  $server_color      = $colorprompt::params::server_color,
  $env_name          = $colorprompt::params::env_name,
  $env_color         = $colorprompt::params::env_color,
  $enable            = $colorprompt::params::enable,
) inherits colorprompt::params {

  class { '::colorprompt::template': }

}
