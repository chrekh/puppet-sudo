# @summary Installs and configures sudo
#
# @author Christer Ekholm
#
# @example
#   include sudo
#
# @param install_package
#   Determines if package for sudo should be installed.
# @param package_name
#   The name of the package to install.
# @param package_ensure
#   What value for 'ensure' to pass to resource type package.
# @param package_provider
#   Override the default package provider.
# @param sudoers
#   The main configuration file for the sudoers plugin. Default is
#   /usr/local/etc/sudoers on FreeBSD, and /etc/sudoers on all other
#   osfamilies.
# @param manage_sudoers
#   Manage the primary sudoers file if true.
# @param includedir
#   The dropin directory for additional config files. Default is
#   /usr/local/etc/sudoers.d on FreeBSD, and /etc/sudoers.d on all other
#   osfamilies.
# @param purge_includedir
#   Purge any files in $includedir not explicitly managed by this class.
# @param includedir_mode
#   The filemode for the includedir
# @param defaultmode
#   The mode for created files.
# @param owner
#   The owner for sudo configfiles.
# @param group
#   The group for sudo configfiles.
# @param use_includedir
#   Add entry for includedir to main sudoer file if true.
# @param conf
#   This is the most important control-structure for configuring sudo. It
#   consists of a hash with the first level key is the destination file (under
#   $includedir), or the special value "_sudoers" for the content of the master
#   sudoers file. There is a default content for this that permits root to run
#   sudo.
class sudo (
  Boolean $install_package           = true,
  String[1] $package_name            = 'sudo',
  String[1] $package_ensure          = 'present',
  Optional[String] $package_provider = undef,
  Stdlib::Unixpath $sudoers          = '/etc/sudoers',
  Boolean $manage_sudoers            = true,
  Stdlib::Unixpath $includedir       = '/etc/sudoers.d',
  Boolean $purge_includedir          = false,
  Stdlib::Filemode $includedir_mode  = '0750',
  Stdlib::Filemode $defaultmode      = '0440',
  String[1] $owner                   = 'root',
  String[1] $group                   = 'root',
  Boolean $use_includedir            = true,
  String[1] $validate_cmd            = '/usr/sbin/visudo -sc %',
  Hash[String,Hash[String,Optional[Any]]] $conf = { '_sudoers' => {} }
) {
  contain sudo::config
  if $install_package {
    contain sudo::install
    Class['sudo::install']
    -> Class['sudo::config']
  }
}
