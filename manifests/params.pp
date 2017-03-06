# == Class opengrok::params
#
# This class is meant to be called from opengrok.
# It sets variables according to platform.
#
class opengrok::params {
  case $::osfamily {
    'RedHat', 'Amazon': {
      $version = 'latest'
      $projects = []
      $manage_tomcat = true
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
