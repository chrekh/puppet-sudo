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
        mode   => '0400',
      }
    }
    $sudo::conf.keys.each | $destination | {
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
      file { $file:
        ensure  => file,
        require => $require_includedir,
        owner   => 0,
        group   => 0,
        mode    => '0400',
        content => epp('sudo/sudoers.epp',{
          dest        => $destination,
          defaults    => $sudo::conf[$destination]['defaults'],
          user_alias  => $sudo::conf[$destination]['user_alias'],
          runas_alias => $sudo::conf[$destination]['runas_alias'],
          host_alias  => $sudo::conf[$destination]['host_alias'],
          cmnd_alias  => $sudo::conf[$destination]['cmnd_alias'],
          rules       => $sudo::conf[$destination]['rules'],
        })
      }
    }
  }
}
