# @summary Installs sudo
#
# @api private
class sudo::install {
  assert_private()

  package { $sudo::package_name:
    ensure   => $sudo::package_ensure,
    provider => $sudo::package_provider,
  }
}
