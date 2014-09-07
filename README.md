#colorprompt

####Table of Contents

##Overview

The colorprompt module. Colors your bash prompt.

##Module Description
The colorprompt module creates /etc/profile.d/colorprompt.sh, which sets a colored prompt. Different colors can be set for (all and spesific) users, servername and environment tag.

##Usage

All interaction with the colorprompt module can do be done through the main colorprompt class.

###I just want a colored prompt, what's the minimum I need?

```puppet
include 'colorprompt'
```

###I want a prompt for my development servers with customised colors.

```puppet
class { 'colorprompt':
   default_usercolor => ['white'],
   custom_usercolors => {
     root => ['red'],
   },
   server_color      => ['cyan'],
   env_name          => ['DEV'],
   env_name          => ['white', 'bg_cyan'],
}
```

###Great! What colors are available

* black
* red
* green
* yellow
* blue
* magenta
* cyan
* white

A background color can also be defnied by using 'bg_(color)'

##Reference

###Classes

####Public Classes

* colorprompt: Main class, includes all other classes.

####Private Classes

* colorprompt::template: Handles the /etc/profile.d/colorprompt.sh file.

###Parameters

####`default_usercolor`

Array. Sets the color for all users. Spesific user colors can be overrided by 'custom_usercolors'. Defaults to ['cyan'].

####`custom_usercolors`

Hash. Sets the color for spesific users. Defaults to { 'root' => ['magenta'] }

####`server_color`

Array. Sets the color for the server name. Defaults to ['white']

####`env_name`

String. Names an environment tag. Examples: 'PROD', 'QA', 'TEST', 'DEV'. Default is not set. 

####`env_color`

Array. Sets the color for of the environment tag. Default is not set. 

####`enable`

Boolean. Set this to false to uninstall colorprompt. Defaults to 'true'.

##Limitations

This module has been built on and tested against Puppet 3.0 and higher.

The module has been tested on:
* RedHat Enterprise Linux 5/6
* CentOS 5/6
* Ubuntu 12.04
* Debian 7

Ubuntu and Debian needs modification to /etc/skel/.bashrc and existing user .bashrc files (comment out PS1 variables).
