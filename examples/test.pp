class { 'colorprompt':
  env_name          => 'TEST',
  env_color         => ['black', 'bg_green'],
  server_color      => ['bright', 'green'],
  default_usercolor => 'cyan',
  custom_usercolors => {
    'root' => 'magenta',
  },
}
