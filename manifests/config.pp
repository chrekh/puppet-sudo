# @summary Configures sudo
#
# @api private
class sudo::config {
  if $sudo::conf {
    if $sudo::use_includedir {
      file { $sudo::includedir:
        ensure => directory,
        owner  => 0,
        group  => 0,
        mode   => $sudo::includedir_mode,
      }
    }
    $sudo::conf.each | $destination,$conf | {
      if $destination == '_sudoers' {
        $file = $sudo::sudoers
        $require_includedir = undef
      } else {
        unless $sudo::use_includedir {
          fail("additional configfile ${destination} can't be used when use_includedir=false")
        }
        $file = "${sudo::includedir}/${destination}"
        $require_includedir = File[$sudo::includedir]
      }
      $filemode = if $conf['mode'] { $conf['mode'] } else { $sudo::defaultmode }
      file { $file:
        ensure  => file,
        require => $require_includedir,
        owner   => 0,
        group   => 0,
        mode    => $filemode,
        content => epp('sudo/sudoers.epp',{
          dest        => $destination,
          defaults    => $conf['defaults'],
          user_alias  => $conf['user_alias'],
          runas_alias => $conf['runas_alias'],
          host_alias  => $conf['host_alias'],
          cmnd_alias  => $conf['cmnd_alias'],
          rules       => $conf['rules'],
        })
      }
    }
  }
}
