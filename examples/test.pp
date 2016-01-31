class { 'colorprompt':
  env_name          => 'TEST',
  env_color         => ['white', 'bg_green'],
  server_color      => 'white',
  default_usercolor => 'cyan',
  custom_usercolors => {
    'root' => 'magenta',
  },
}
