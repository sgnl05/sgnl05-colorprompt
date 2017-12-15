# Default parameters
class colorprompt::params {

  $ensure            = present
  $path              = '/etc/profile.d/colorprompt.sh'
  $default_usercolor = 'cyan'
  $path_color        = undef
  $custom_usercolors = { 'root' => 'magenta' }
  $server_color      = undef
  $env_name          = undef
  $env_color         = undef

  case $::osfamily {

    'RedHat': {
      $prompt      = '${env}[${userColor}\u\[\e[0m\]@${serverColor}\h\[\e[0m\] ${pathColor}\W\[\e[0m\]]\\$ '
      $modify_skel = false
      $modify_root = false
    }

    'Debian': {
      $prompt      = '${env}[${userColor}\u\[\e[0m\]@${serverColor}\h\[\e[0m\] ${pathColor}\w\[\e[0m\]]\\$ '
      $modify_skel = true
      $modify_root = true
    }

    default: {
      fail("Unsupported osfamily: ${::osfamily}")
    }

  }

}
