class colorprompt::file inherits colorprompt {

  if $enable == true {
    $ensure = 'file'
  } else {
    $ensure = 'absent'
  }

  file { '/etc/profile.d/colorprompt.sh':
    ensure  => $ensure,
    backup  => false,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('colorprompt/colorprompt.erb'),
  }

}
