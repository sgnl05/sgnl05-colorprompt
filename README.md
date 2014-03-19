#colorprompt

####Table of Contents

##Overview

The colorprompt module. Colors your bash prompt.

##Module Description
The colorprompt module creates /etc/profile.d/colorprompt.sh, which sets a colored prompt. Different colors can be set through predefined server profiles.

##Usage

All interaction with the colorprompt module can do be done through the main colorprompt class.

###I just want a fancy prompt, what's the minimum I need?

```puppet
include 'colorprompt'
```

###I want a TEST profile.

```puppet
class { 'colorprompt':
   profile => 'TEST',
}
```

###Great! What profiles are available by default?

* PROD
* QA
* TEST
* MGMT

You can add new ones or modify existing profiles in manifests/init.pp

##Reference

###Classes

####Public Classes

* colorprompt: Main class, includes all other classes.

####Private Classes

* colorprompt::file: Handles the /etc/profile.d/colorprompt.sh file.

###Parameters

####`profile`

Determines which profile Puppet should use for the colorprompt template. 

####`enable`

True or false. Default is true.  Set this to false to uninstall colorprompt.

##Limitations

This module has been built on and tested against Puppet 2.7 and higher.

The module has been tested on:
* RedHat Enterprise Linux 5/6
* CentOS 5/6
* Ubuntu 12.04
* Debian 7

Ubuntu and Debian needs modification of /etc/skel/.bashrc (comment out PS1 variables)
