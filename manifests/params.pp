class colorprompt::params {

  case $::kernel {

    Linux: {
      $default_usercolor = [ 'cyan' ]
      $custom_usercolors = { 'root' => ['magenta'] }
      $server_color      = [ 'white' ]
      $env_name          = undef
      $env_color         = [undef]
      $enable            = true
    }

    default: {
      fail("The ${module_name} module is not supported on an ${::kernel} based system.")
    }

  }

}
