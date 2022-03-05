# @summary Installs and configures sudo
#
# @example
#   include sudo
# @param install_package
#   Determines if package for sudo should be installed.
# @param package_name
#   The name of the package to install.
# @param package_ensure
#   What value for 'ensure' to pass to resource type package.
# @param package_provider
#   Override the default package provider.
# @param sudoers
#   The main configuration file for the sudoers plugin.
# @param includedir
#   The dropin directory for additional config files.
# @param use_includedir
#   Add entry for includedir to main sudoer file if true.
class sudo (
  Boolean $install_package           = true,
  String[1] $package_name            = 'sudo',
  String[1] $package_ensure          = 'present',
  Optional[String] $package_provider = undef,
  Stdlib::Unixpath $sudoers          = '/etc/sudoers',
  Stdlib::Unixpath $includedir       = '/etc/sudoers.d',
  Boolean $use_includedir            = true,
  Hash[String,Hash[String,Optional[Any]]] $conf = undef,
) {
  contain sudo::config
  if $install_package {
    contain sudo::install
    Class['sudo::install']
    -> Class['sudo::config']
  }
}
