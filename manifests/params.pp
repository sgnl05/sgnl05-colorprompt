# Default parameters
class colorprompt::params {

  $ensure                  = present
  $path                    = '/etc/profile.d/colorprompt.sh'
  $default_usercolor       = 'cyan'
  $custom_usercolors       = { 'root' => 'magenta' }
  $server_color            = undef
  $pwd_color               = undef
  $env_name                = undef
  $env_color               = undef
  $git_prompt              = false
  $bash_completion_dir     = '/etc/bash_completion.d'
  $bash_completion_package = 'bash-completion'
  $git_package             = 'git'

  case $::osfamily {

    'RedHat': {
      $git_prompt_path = '/usr/share/git-core/contrib/completion/git-prompt.sh'
      $prompt          = '${env}[${userColor}\u\[\e[0m\]@${serverColor}\h\[\e[0m\] ${pwdColor}\W\[\e[0m\]]\\$${git_prompt} '
      $modify_skel     = false
      $modify_root     = false
    }

    'Debian': {
      $git_prompt_path = '/usr/lib/git-core/git-sh-prompt'
      $prompt          = '${env}[${userColor}\u\[\e[0m\]@${serverColor}\h\[\e[0m\] ${pwdColor}\w\[\e[0m\]]\\$${git_prompt} '
      $modify_skel     = true
      $modify_root     = true
    }

    default: {
      fail("Unsupported osfamily: ${::osfamily}")
    }

  }

  # first list colors
  $fg_colors = {
    black   => ';30',
    red     => ';31',
    green   => ';32',
    yellow  => ';33',
    blue    => ';34',
    magenta => ';35',
    cyan    => ';36',
    white   => ';37',
    empty   => '',
  }
   
  # second list colors
  $bg_colors = {
    bg_black   => ';40',
    bg_red     => ';41',
    bg_green   => ';42',
    bg_yellow  => ';43',
    bg_blue    => ';44',
    bg_magenta => ';45',
    bg_cyan    => ';46',
    bg_white   => ';47',
    empty      => '',
  }

  # third list colors
  $styles = {
    bright    => ';1',
    faint     => ';2',
    underline => ';4',
    blink     => ';5',
    empty     => '',
  }

}
