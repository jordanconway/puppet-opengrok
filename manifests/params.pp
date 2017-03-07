# == Class opengrok::params
#
# This class is meant to be called from opengrok.
# It sets variables according to platform.
#
class opengrok::params {
  case $::osfamily {
    'RedHat', 'Amazon': {
      $url = 'https://github.com/OpenGrok/OpenGrok/releases/download/0.13-rc10/opengrok-0.13-rc10.tar.gz'
      $projects = {}
      $install_ctags = true
      $ctags_package = 'ctags'
      $manage_tomcat = true
      $opengrok_dir = '/opt/opengrok'
      $manage_git = true
      $service_name = 'tomcat'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
