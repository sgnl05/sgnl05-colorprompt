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
      $prompt      = '${env}[${userColor}\u\[\e[0m\]@${serverColor}\h\[\e[0m\] \W]\\$ ' 
      $modify_skel = false
      $modify_root = false
    }

    'Debian': {
      $prompt      = '${env}[${userColor}\u\[\e[0m\]@${serverColor}\h\[\e[0m\] \w]\\$ '
      $modify_skel = true
      $modify_root = true
    }

    default: {
      fail("Unsupported osfamily: ${::osfamily}")
    }

  }

}
