# == Class opengrok::params
#
# This class is meant to be called from opengrok.
# It sets variables according to platform.
#
class opengrok::params {
  case $::osfamily {
    'RedHat', 'Amazon': {
      $url = 'https://github.com/OpenGrok/OpenGrok/files/467358/opengrok-0.12.1.6.tar.gz.zip'
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
