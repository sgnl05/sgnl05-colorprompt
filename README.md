# colorprompt

## Overview

The colorprompt module. Colors your bash prompt.

## Module Description
The colorprompt module creates /etc/profile.d/colorprompt.sh, which sets a colored prompt. Different colors can be set for (all and specific) users, server name and environment tag.

## Usage

All interaction with the colorprompt module can be done through the main colorprompt class.

### I just want a colored prompt, what's the minimum I need?

```puppet
include 'colorprompt'
```

### I want a prompt for my production server with customised colors.

```puppet
class { 'colorprompt':
   env_name          => 'PROD',
   env_color         => ['white', 'bg_red'],
   server_color      => 'red',
   default_usercolor => 'cyan',
   custom_usercolors => {
     'root' => 'magenta',
   },
}
```

### What does the example above look like?

![prompt](https://raw.githubusercontent.com/sgnl05/sgnl05-colorprompt/master/example.png)

### Great! What colors are available?

#### Default colors

* Foreground colors (`$::colorprompt::params::fg_colors`):
  * black
  * red
  * green
  * yellow
  * blue
  * magenta
  * cyan
  * white
  * empty
* Background colors (`$::colorprompt::params::bg_colors`):
  * bg_black
  * bg_red
  * bg_green
  * bg_yellow
  * bg_blue
  * bg_magenta
  * bg_cyan
  * bg_white
  * empty
* Styles (`$::colorprompt::params::styles`):
  * bright
  * faint
  * underline
  * blink
  * empty

You can set your available settings in hashes.
A background color can also be defined by using bg_(color).Foreground and background colors can be combined by using arrays instead of strings (see env_color in example above).

## Reference

### Classes

#### Public Classes

* colorprompt: Main and only class.

### Parameters

#### `ensure`

String. Ensure if file /etc/profile.d/colorprompt.sh is present or absent.
Defaults to present.

#### `default_usercolor`

String or array. Sets the color for all users. Specific user colors can be overrided by 'custom_usercolors'.
Defaults to 'cyan'.

#### `custom_usercolors`

Hash. Sets the color for specific users. Example: custom_usercolors => { 'apache' => 'blue', 'tomcat' => 'yellow' }
Default is { 'root' => 'magenta' }

#### `server_color`

String or array. Sets the color for the server name. 
Defaults to unset.

#### `pwd_color`

String or array. Sets the color for pwd.
Defaults to unset.

#### `env_name`

String: Names an environment tag. Examples: 'PROD', 'QA', 'TEST', 'DEV'.
Defaults to unset.

#### `env_color`

String or array. Sets the color for of the environment tag.
Defaults to unset

#### `git_prompt`

Boolean. Enable or disable [git_prompt](https://github.com/git/git/blob/master/contrib/completion/git-prompt.sh "git_promt on github").
Default is false

#### `prompt`

String. Sets the final PS1 variable. This is an advanced setting, and should probably be left untouched unless you know what you're doing. :)
Default varies with osfamily.

#### `modify_skel`

Boolean. Comments out PS1 variables in /etc/skel/.bashrc
Default varies with osfamily.

#### `modify_root`

Boolean. Comments out PS1 variables in /root/.bashrc
Default varies with osfamily

#### `bash_completion_package`
String. Package name bash-completion (install only if git_prompt equal true)
Defaults to 'bash-completion'

#### `git_package`
String. Package name git (install only if git_prompt equal true)
Defaults to 'git'

#### `fg_colors`
Hash. Hash of foreground colors.
Default: value of `$::colorprompt::params::fg_colors`.

#### `bg_colors`
Hash. Hash of background colors.
Default: value of `$::colorprompt::params::bg_colors.`

#### `styles`
Hash. Hash of styles.
Default: value of `$::colorprompt::params::styles`.


## Limitations

This module has been tested against Puppet 3.0 and higher.

The module has been tested on:
* RedHat & CentOS 5/6/7
* Ubuntu 12.04 & 14.04
* Debian 6/7/8
* Fedora 22/23

Ubuntu and Debian need modification to existing user ~/.bashrc files (comment out PS1 variables).

## Development

### Contributing

Please use the issue tracker (https://github.com/sgnl05/sgnl05-colorprompt/issues) for any type of contribution. 
