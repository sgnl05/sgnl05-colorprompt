class colorprompt::params {

  case $::kernel {

    Linux: {
      $black      = ';30'
      $red        = ';31'
      $green      = ';32'
      $yellow     = ';33'
      $blue       = ';34'
      $magenta    = ';35'
      $cyan       = ';36'
      $white      = ';37'

      $bg_black   = ';40'
      $bg_red     = ';41'
      $bg_green   = ';42'
      $bg_yellow  = ';43'
      $bg_blue    = ';44'
      $bg_magenta = ';45'
      $bg_cyan    = ';46'
      $bg_white   = ';47'

      $bright     = ';1'
      $faint      = ';2'
      $underline  = ';4'
      $blink      = ';5'

      $profile      = 'default'
      $server_color = [$white]
      $user_color   = [$cyan]
      $root_color   = [$magenta]
      $enable       = true
    }

    default: {
      fail("The ${module_name} module is not supported on an ${::kernel} based system.")
    }

  }

}
