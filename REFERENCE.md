# Reference

<!-- DO NOT EDIT: This document was generated by Puppet Strings -->

## Table of Contents

### Classes

#### Public Classes

* [`sudo`](#sudo): Installs and configures sudo

#### Private Classes

* `sudo::config`: Configures sudo
* `sudo::install`: Installs sudo

## Classes

### <a name="sudo"></a>`sudo`

Installs and configures sudo

#### Examples

##### 

```puppet
include sudo
```

#### Parameters

The following parameters are available in the `sudo` class:

* [`install_package`](#install_package)
* [`package_name`](#package_name)
* [`package_ensure`](#package_ensure)
* [`package_provider`](#package_provider)
* [`sudoers`](#sudoers)
* [`manage_sudoers`](#manage_sudoers)
* [`includedir`](#includedir)
* [`purge_includedir`](#purge_includedir)
* [`includedir_mode`](#includedir_mode)
* [`defaultmode`](#defaultmode)
* [`owner`](#owner)
* [`group`](#group)
* [`use_includedir`](#use_includedir)
* [`validate_cmd`](#validate_cmd)
* [`conf`](#conf)

##### <a name="install_package"></a>`install_package`

Data type: `Boolean`

Determines if package for sudo should be installed.

Default value: ``true``

##### <a name="package_name"></a>`package_name`

Data type: `String[1]`

The name of the package to install.

Default value: `'sudo'`

##### <a name="package_ensure"></a>`package_ensure`

Data type: `String[1]`

What value for 'ensure' to pass to resource type package.

Default value: `'present'`

##### <a name="package_provider"></a>`package_provider`

Data type: `Optional[String]`

Override the default package provider.

Default value: ``undef``

##### <a name="sudoers"></a>`sudoers`

Data type: `Stdlib::Unixpath`

The main configuration file for the sudoers plugin. Default is
/usr/local/etc/sudoers on FreeBSD, and /etc/sudoers on all other
osfamilies.

Default value: `'/etc/sudoers'`

##### <a name="manage_sudoers"></a>`manage_sudoers`

Data type: `Boolean`

Manage the primary sudoers file if true.

Default value: ``true``

##### <a name="includedir"></a>`includedir`

Data type: `Stdlib::Unixpath`

The dropin directory for additional config files. Default is
/usr/local/etc/sudoers.d on FreeBSD, and /etc/sudoers.d on all other
osfamilies.

Default value: `'/etc/sudoers.d'`

##### <a name="purge_includedir"></a>`purge_includedir`

Data type: `Boolean`

Purge any files in $includedir not explicitly managed by this class.

Default value: ``false``

##### <a name="includedir_mode"></a>`includedir_mode`

Data type: `Stdlib::Filemode`

The filemode for the includedir

Default value: `'0750'`

##### <a name="defaultmode"></a>`defaultmode`

Data type: `Stdlib::Filemode`

The mode for created files.

Default value: `'0440'`

##### <a name="owner"></a>`owner`

Data type: `String[1]`

The owner for sudo configfiles.

Default value: `'root'`

##### <a name="group"></a>`group`

Data type: `String[1]`

The group for sudo configfiles.

Default value: `'root'`

##### <a name="use_includedir"></a>`use_includedir`

Data type: `Boolean`

Add entry for includedir to main sudoer file if true.

Default value: ``true``

##### <a name="validate_cmd"></a>`validate_cmd`

Data type: `String[1]`

Command used to check created sudoers files for syntax errors.

Default value: `'/sbin/visudo -sc %'`

##### <a name="conf"></a>`conf`

Data type: `Hash[String,Hash[String,Optional[Any]]]`

This is the most important control-structure for configuring sudo. It
consists of a hash with the first level key is the destination file (under
$includedir), or the special value "_sudoers" for the content of the master
sudoers file. There is a default content for this that permits root to run
sudo.

Default value: `{ '_sudoers' => {} }`

