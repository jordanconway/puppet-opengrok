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
      $manage_git = true
      $service_name = 'tomcat'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
