# sudo

Puppet module for configuring sudo.
## Table of Contents

1. [Description](#description)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Example - Hiera example of sudo configuration](#example)

## Description

Installs and configures sudo.

This modules can configure most features described in sudoers(5), both in the
master sudoers file, and in separate files located in a includedir
(/etc/sudoers.d). My motivation for creating this module even when there is
several modules for sudo available already, is to be able to to generate all
possible sudoers(5) content, using structured data merged from possibly several
hiera levels.

Note that even if the individual files created are validated using
$sudo::validate_cmd there is no guarantee that the resulting sudo configuration
doesn't contain syntax errors that breaks sudo.

## Usage

```puppet
class { 'sudo': }
```

The main feature is located in a single hash provided to sudo as parameter
conf. This is possible to specify either as class-parameter or hieradata.

The keys in $sudo::conf is what file to write configurations to, the special
key '_sudoers' is used for the main sudo configuration file $sudo::sudoers
(normally '/etc/sudoers'), other keys specifies files to create under
$sudo::includedir (normally /etc/sudoers.d)

The value for $sudo::conf[file] can be one of:

* mode, File permission mode for the file, default $sudo::defaultmode
* defaults, Defaults specifications as described by sudoers(5)
* user_alias, A hash whith array of users.
* runas_alias, A hash with array of target users.
* host_alias, A hash with array of hosts.
* cmnd_alias, A hash with array of commands.
* user_specs, A array of hashes with user specs with
  - users: Array of users
  - runas: Hash of target user & group
  - options: Array of options
  - commands: Array of commands

## Note about default value for sudo::conf[_sudoers]

The default value for sudo::conf[_sudoers] only contains the rule to allow root
to run sudo. Which means that unless you provide configuration for
sudo::conf[_sudoers] the main sudoers file will be cleared (except for root and
the include directive if sudo::use_includedir is true) wiping whatever your
OS/Distribution have provided.

My arguments against providing a distribution-specific defaults is:

* It's easier to maintain a consistent sudoers configuration in a environment
  consistiong of multiple distributions.

* By not having any settings in main sudoers file the defaults are determined
  by the installed sudo package, and is well documented in sudoers(5).

* Future changes made by distributions would not be included unless I regularly
  adapted them here also.


## Hiera example

```yaml
---
lookup_options:
  sudo::conf:
    merge:
      strategy: deep
sudo::conf:
  _sudoers:
    defaults:
      - Defaults:
          - insults
          - '!always_set_home'
```

This will result in sudoers file containing.

```
## Managed by puppet class sudo
## Do not edit

# Override built-in defaults
Defaults insults, !always_set_home

# User specification
root ALL = (ALL:ALL)  ALL

## Read drop-in files from /etc/sudoers.d (the # here does not mean a comment)
#includedir /etc/sudoers.d
```

There is also a quite large example in [HIERA_EXAMPLE.md](https://github.com/chrekh/puppet-sudo/blob/main/HIERA_EXAMPLE.md)
based on the examples in sudoers(5), which will results in
/etc/sudoers.d/example with content [EXAMPLE.md](https://github.com/chrekh/puppet-sudo/blob/main/EXAMPLE.md)
