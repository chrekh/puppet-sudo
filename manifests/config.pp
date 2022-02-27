# @summary Configures sudo
#
# @api private
class sudo::config {
  if $sudo::conf {
    $sudo::conf.keys.each | $destination | {
      if $destination == '_sudoers' {
        $file = $sudo::sudoers
      }
      else {
        unless $sudo::use_includedir {
          fail("additional configfile ${destination} can't be used when use_includedir=false")
        }
        $file = "${sudo::includedir}/${destination}"
      }
      file { $file:
        ensure  => file,
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
        })
      }
    }
  }
}
