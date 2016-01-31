class { 'colorprompt':
  env_name          => 'QA',
  env_color         => ['black', 'bg_yellow'],
  server_color      => 'yellow',
  default_usercolor => 'cyan',
  custom_usercolors => {
    'root' => 'magenta',
  },
}
