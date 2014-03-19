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
# [Remember: No empty lines between comments and class definition]
class colorprompt (
  $profile      = $colorprompt::params::profile,
  $enable       = $colorprompt::params::enable,
) inherits colorprompt::params {

  validate_string($profile)
  validate_bool($enable)

  $black      = $colorprompt::params::black
  $red        = $colorprompt::params::red
  $green      = $colorprompt::params::green
  $yellow     = $colorprompt::params::yellow
  $blue       = $colorprompt::params::blue
  $magenta    = $colorprompt::params::magenta
  $cyan       = $colorprompt::params::cyan
  $white      = $colorprompt::params::white

  $bg_black   = $colorprompt::params::bg_black
  $bg_red     = $colorprompt::params::bg_red
  $bg_green   = $colorprompt::params::bg_green
  $bg_yellow  = $colorprompt::params::bg_yellow
  $bg_blue    = $colorprompt::params::bg_blue
  $bg_magenta = $colorprompt::params::bg_magenta
  $bg_cyan    = $colorprompt::params::bg_cyan
  $bg_white   = $colorprompt::params::bg_white

  $bright     = $colorprompt::params::bright
  $faint      = $colorprompt::params::faint
  $underline  = $colorprompt::params::underline
  $blink      = $colorprompt::params::blink

  # PROD profile
  if $profile == 'PROD' {
    $profile_text   = 'PROD'
    $profile_color  = [$bright, $white, $bg_red]
    $server_color   = [$red]
  }

  # QA profile
  elsif $profile == 'QA' {
    $profile_text   = 'QA'
    $profile_color  = [$black, $bg_yellow]
    $server_color   = [$yellow]
  }

  # TEST profile
  elsif $profile == 'TEST' {
    $profile_text   = 'TEST'
    $profile_color  = [$black, $bg_green]
    $server_color   = [$green]
  }

  # Management profile
  elsif $profile == 'MGMT' {
    $profile_text   = 'MGMT'
    $profile_color  = [$bright, $blue]
  }

  # Default profile
  else {
    $profile_text   = undef
    $profile_color  = undef
    $server_color = [$white]
    $user_color   = [$cyan]
    $root_color   = [$magenta]
  }

  class { '::colorprompt::file': }

}
