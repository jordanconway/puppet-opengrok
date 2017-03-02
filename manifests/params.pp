# == Class opengrok::params
#
# This class is meant to be called from opengrok.
# It sets variables according to platform.
#
class opengrok::params {
  case $::osfamily {
    'Debian': {
      $package_name = 'opengrok'
      $service_name = 'opengrok'
    }
    'RedHat', 'Amazon': {
      $package_name = 'opengrok'
      $service_name = 'opengrok'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
