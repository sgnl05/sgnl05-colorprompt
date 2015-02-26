# == Class: colorprompt::template
#
# This class handles the colorprompt.sh file
#
# === Parameters
#
# === Variables
#
# === Examples
#
#  class { 'colorprompt::template': }
#
class colorprompt::template {

  if $colorprompt::enable == true {
    $ensure = 'file'
  } else {
    $ensure = 'absent'
  }

  file { '/etc/profile.d/colorprompt.sh':
    ensure  => $ensure,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('colorprompt/colorprompt.erb'),
  }

}
