# Default parameters
class colorprompt::params {

  $ensure            = present
  $path              = '/etc/profile.d/colorprompt.sh'
  $default_usercolor = 'cyan'
  $custom_usercolors = { 'root' => 'magenta' }
  $server_color      = undef
  $env_name          = undef
  $env_color         = undef

  case $::osfamily {

    'RedHat': {
      $modify_skel = false
      $modify_root = false
    }

    'Debian': {
      $modify_skel = true
      $modify_skel = true
    }

}
