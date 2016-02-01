class { 'colorprompt':
  env_name          => 'TEST',
  env_color         => ['bright', 'black', 'bg_green'],
  server_color      => ['birght', 'green'],
  default_usercolor => 'cyan',
  custom_usercolors => {
    'root' => 'magenta',
  },
}
