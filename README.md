# sudo

Puppet module for configuring sudo. **Not yet ready for production!**

## Table of Contents

1. [Description](#description)
1. [Todo](#todo)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Example - Hiera example of sudo configuration](#example)

## Description

Installs and configures sudo.

This modules can configure most features described in sudoers(5), both in one
main files, and in separate files located in a includedir (/etc/sudoers.d)

## Todo

There still remains some work to do before this can be used in production
environments. Use this only for testing it.  I appreciate suggestions for
improvements (preferably by pull requests)

Since the most important method for controlling this module is with the quite
complex hash $sudo::conf the datastructure needs to be documented a lot
more. For now it's mainly documented by example.

The datastructure for $sudo::conf might also need some redesigning.

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
** users: Array of users
** runas: Hash of target user & group
** options: Array of options
** commands: Array of commands


## Hiera example

```yaml
sudo::conf:
  _sudoers:
    defaults:
      - Defaults:
          - insults
```

This will result in /etc/sudoers containing

```
## Managed by puppet class sudo
## Do not edit

# Override built-in defaults
Defaults insults

## Read drop-in files from /etc/sudoers.d (the # here does not mean a comment)
#includedir /etc/sudoers.d
```

There is also a quite large example in [HIERA_EXAMPLE.md](https://github.com/chrekh/puppet-sudo/blob/main/HIERA_EXAMPLE.md)
based on the examples in sudoers(5), which will results in
/etc/sudoers.d/example with content [EXAMPLE.md](https://github.com/chrekh/puppet-sudo/blob/main/EXAMPLE.md)
