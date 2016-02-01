# == Class: colorprompt
#
# This module adds colors to your bash prompt.
#
# === Parameters
#
# [*ensure*]
#   Ensure if present or absent.
#   Type: boolean
#   Default: present
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
#   Ensure if present or absent.
#   Type: string or array
#   Default: undef
#
# [*env_name*]
#   Ensure if present or absent.
#   Type: string
#   Default: undef
#
# [*env_color*]
#   Ensure if present or absent.
#   Type: string or array
#   Default: undef
#
# === Examples
#
#  class { 'colorprompt':
#     ensure            => present,
#     env_name          => 'PROD',
#     env_color         => ['white', 'bg_red'],
#     server_color      => 'red',
#     default_usercolor => 'cyan',
#     custom_usercolors => {
#       'root' => 'magenta',
#     },
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
  $ensure            = $colorprompt::params::ensure,
  $default_usercolor = $colorprompt::params::default_usercolor,
  $custom_usercolors = $colorprompt::params::custom_usercolors,
  $server_color      = $colorprompt::params::server_color,
  $env_name          = $colorprompt::params::env_name,
  $env_color         = $colorprompt::params::env_color,
  $modify_skel       = $colorprompt::params::modify_skel,
  $modify_root       = $colorprompt::params::modify_root,
) inherits colorprompt::params {

  file { '/etc/profile.d/colorprompt.sh':
    ensure  => $ensure,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('colorprompt/colorprompt.erb'),
  }

}
