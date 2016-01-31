class { 'colorprompt':
  env_name          => 'PROD',
  env_color         => ['white', 'bg_red'],
  server_color      => 'red',
  default_usercolor => 'cyan',
  custom_usercolors => {
    'root' => 'magenta',
  },
}
