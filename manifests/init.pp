# == Class: colorprompt
#
# This module adds colors to your bash prompt.
#
# === Parameters
#
# [*ensure*]
#   Ensure if present or absent.
#   Type: string
#   Default: present
#
# [*path*]
#   Path to colorprompt.sh file
#   Type: string
#   Default: /etc/profile.d/colorprompt.sh
#
# [*default_usercolor*]
#   Sets the color for all users. Spesific user colors can be overrided by 'custom_usercolors'. Defaults to 'cyan'.
#   Type: string or array
#   Default: 'cyan'
#
# [*custom_usercolors*]
#   Sets the color for spesific users.
#   Type: hash
#   Default: { 'root' => 'magenta' }
#
# [*server_color*]
#   Sets the color for the server name.
#   Type: string or array
#   Default: undef
#
# [*pwd_color*]
#   Sets the color for pwd.
#   Type: string or array
#   Default: undef
#
# [*env_name*]
#   Sets the name of environment.
#   Type: string
#   Default: undef
#
# [*env_color*]
#   Sets the color for environment.
#   Type: string or array
#   Default: undef
#
# [*git_prompt*]
#   Enable or disable git_prompt.
#   Type: boolean
#   Default: false
#
# [*prompt*]
#   Sets the final $PS1 variable. Use ${env}, ${userColor} and ${serverColor}
#   Type: string
#   Default:
#   '${env}[${userColor}\u\[\e[0m\]@${serverColor}\h\[\e[0m\] ${pwdColor}\W\[\e[0m\]]\\$${git_prompt} ' on RedHat
#   '${env}[${userColor}\u\[\e[0m\]@${serverColor}\h\[\e[0m\] ${pwdColor}\w\[\e[0m\]]\\$${git_prompt} ' on Debian
#
# [*modify_skel*]
#   Comments out PS1 variables in /etc/skel/.bashrc on Debian distributions
#   Type: boolean
#   Default: true on Debian, false on RedHat
#
# [*modify_root*]
#   Comments out PS1 variables in /root/.bashrc on Debian distributions
#   Type: boolean
#   Default: true on Debian, false on RedHat
#
# [*bash_completion_package*]
#   Package name bash-completion (install only if git_prompt equal true).
#   Type: string
#   Default: bash-completion
#
# [*git_package*]
#   Package name git (install only if git_prompt equal true).
#   Type: string
#   Default: git
#
# [*fg_colors*]
#   Hash of foreground colors { name => code }
#   Type: Hash
#   Default: value of $::colorprompt::params::fg_colors.
#
# [*bg_colors*]
#   Hash of background colors { name => code }
#   Type: Hash
#   Default: value of $::colorprompt::params::bg_colors.
#
# [*styles*]
#   Hash of styles { name => code }
#   Type: Hash
#   Default: value of $::colorprompt::params::styles.
#
# === Examples
#
#  class { 'colorprompt':
#     ensure            => present,
#     env_name          => 'PROD',
#     env_color         => ['white', 'bg_red'],
#     server_color      => 'red',
#     pwd_color         => [ 'blue', 'empty', 'bright'],
#     default_usercolor => 'cyan',
#     custom_usercolors => {
#       'root' => 'magenta',
#     },
#     git_prompt        => true,
#  }
#
# === Authors
#
# Gjermund Jensvoll <gjerjens@gmail.com>
#
# === Copyright
#
# Copyright 2014-2015 Gjermund Jensvoll
#
class colorprompt (
  $ensure                  = $colorprompt::params::ensure,
  $path                    = $colorprompt::params::path,
  $default_usercolor       = $colorprompt::params::default_usercolor,
  $custom_usercolors       = $colorprompt::params::custom_usercolors,
  $server_color            = $colorprompt::params::server_color,
  $pwd_color               = $colorprompt::params::pwd_color,
  $env_name                = $colorprompt::params::env_name,
  $env_color               = $colorprompt::params::env_color,
  $git_prompt              = $colorprompt::params::git_prompt,
  $git_prompt_path         = $colorprompt::params::git_prompt_path,
  $prompt                  = $colorprompt::params::prompt,
  $modify_skel             = $colorprompt::params::modify_skel,
  $modify_root             = $colorprompt::params::modify_root,
  $bash_completion_package = $colorprompt::params::bash_completion_package,
  $git_package             = $colorprompt::params::git_package,
  $fg_colors            = $colorprompt::params::fg_colors,
  $bg_colors           = $colorprompt::params::bg_colors,
  $styles            = $colorprompt::params::styles,
) inherits colorprompt::params {

  validate_re($ensure, '^(present|absent)$',
    "${ensure} is not supported for ensure. Allowed values are 'present' and 'absent'.")

  validate_absolute_path(
    $path,
    $git_prompt_path,
  )

  validate_string(
    $prompt,
    $bash_completion_package,
    $git_package,
  )

  validate_bool(
    $git_prompt,
    $modify_skel,
    $modify_root,
  )

  validate_hash(
    $custom_usercolors,
    $fg_colors,
    $bg_colors,
    $styles,
  )

  if empty($custom_usercolors) {
    fail('Value of parameter $custom_usercolors must be not empty!')
  } else {
    $custom_usercolors.each | $user, $colors | {
      validate_colors($colors, "Values of \$custom_usercolors not correct for user '${user}'! Value")
    }
  }

  unless is_string($default_usercolor) or is_array($default_usercolor) {
    fail('Value of parameter $default_usercolor must be string or array!')
  } else {
    validate_colors($default_usercolor, "Values of \$default_usercolor not correct! Value")
  }

  if empty($default_usercolor) {
    fail('Value of parameter $default_usercolor must be not empty!')
  }
  
  if $server_color {
    if empty($server_color) {
      fail('Value of parameter $server_color must be not empty!')
    }
    unless is_string($server_color) or is_array($server_color) {
      fail('Value of parameter $server_color must be string or array!')
    } else {
      validate_colors($server_color, "Values of \$server_color not correct! Value")
    }
  }

  if $pwd_color {
    if empty($pwd_color) {
      fail('Value of parameter $pwd_color must be not empty!')
    }
    unless is_string($pwd_color) or is_array($pwd_color) {
      fail('Value of parameter $pwd_color must be string or array!')
    } else {
      validate_colors($pwd_color, "Values of \$pwd_color not correct! Value")
    }
  }

  if $env_name {
    validate_string($env_name)
    if empty($env_name) {
      fail('Value of parameter $env_name must be not empty!')
    }
    if $env_color {
      if empty($env_color) {
        fail('Value of parameter $env_color must be not empty!')
      }
      unless is_string($env_color) or is_array($env_color) {
        fail('Value of parameter $env_color must be string or array!')
      } else {
        validate_colors($env_color, "Values of \$env_color not correct! Value")
      }
    }
  }

  file { 'colorprompt.sh':
    ensure  => $ensure,
    path    => $path,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('colorprompt/colorprompt.erb'),
  }

  if $git_prompt {
    $packages = [$bash_completion_package, $git_package]
    ensure_packages($packages)
  }
  file { "${::colorprompt::params::bash_completion_dir}/git-prompt":
    ensure  => $git_prompt ? {
      true    => present,
      default => absent,
    },
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('colorprompt/git-prompt.erb'),
    require => [
      Package[$bash_completion_package],
      Package[$git_package],
    ],
  }

  if $modify_skel {
    exec { 'modify_skel':
      command     => 'sed -i \'/^if \[ "\$color_prompt" = yes \]; then/,/fi/s/^/#/\' /etc/skel/.bashrc',
      path        => '/bin:/usr/bin:/sbin:/usr/sbin',
      refreshonly => true,
      subscribe   => File['colorprompt.sh'],
    }
  }

  if $modify_root {
    exec { 'modify_root':
      command     => 'sed -i \'/^if \[ "\$color_prompt" = yes \]; then/,/fi/s/^/#/\' /root/.bashrc',
      path        => '/bin:/usr/bin:/sbin:/usr/sbin',
      refreshonly => true,
      subscribe   => File['colorprompt.sh'],
    }
  }

}
