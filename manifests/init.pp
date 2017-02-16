# colorprompt
#
# Main class and only class.
#
# @param ensure [String] Whether to install colorprompt scipt. Values: 'present', 'absent'. Default value: 'present'.
# @param path [Stdlib] Stdlib::Absolutepath. Specifies path for the colorprompt script. Default value: '/etc/profile.d/colorprompt.sh'.
# @param default_usercolor [Optional Variant[Array[String], String]] Sets the color for all users. Spesific user colors can be overrided by 'custom_usercolors'. Default value: 'cyan'.
# @param custom_usercolors [Optional Hash[String, [Variant[Array[String], String]]]] Sets the color for spesific users. Default value: '{ 'root' => 'magenta' }'.
# @param server_color [Optional Variant[Array[String], String]] Sets the server name color. Default value: undef.
# @param env_name [Optional String] Sets an environment name. Default value: undef.
# @param env_color [Optional Array[String]] Sets the color for the environment tag. Default value: undef.
# @param prompt [String] Sets the final $PS1 variable. Use ${env}, ${userColor} and ${serverColor} for set environment, user colors and server color. Default value: varies by operating system.
# @param modify_skel [Boolean] Comments out PS1 variables in /etc/skel/.bashrc on Debian distributions. Default value: varies by operating system.
# @param modify_root [Boolean] Comments out PS1 variables in /root/.bashrc on Debian distributions. Default value: varies by operating system.
# @param ansi Sets the ansi codes for styles and colors. Default value: See data/common.yaml

class colorprompt (
  Enum['present', 'absent'] $ensure,
  Stdlib::Absolutepath $path,
  Optional[Variant[Array[String], String]] $default_usercolor,
  Optional[Hash[String, [Variant[Array[String], String]]]] $custom_usercolors,
  Optional[Variant[Array[String], String]] $server_color,
  Optional[String] $env_name,
  Optional[Array[String]] $env_color,
  String $prompt,
  Boolean $modify_skel,
  Boolean $modify_root,
  Hash[String, Integer] $ansi,
) {

  file { 'colorprompt.sh':
    ensure  => $ensure,
    path    => $path,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('colorprompt/colorprompt.erb'),
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
