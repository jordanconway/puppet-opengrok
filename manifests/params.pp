# Class opengrok::params
# ===========================
#
# This class is meant to be called from opengrok.
# It sets variables according to platform.
# @example default $download_url
#   $download_url = 'https://github.com/OpenGrok/OpenGrok/files/467358/opengrok-0.12.1.6.tar.gz.zip'
# @example default $projects
#   $projects = {}
# @example default $install_ctags
#   $install_ctags = true
# @example default $ctags_package
#   $ctags_package = 'ctags'
# @example default $manage_tomcat
#   $manage_tomcat = true
# @example default $opengrok_dir
#   $opengrok_dir = '/opt/opengrok'
# @example default $manage_git
#   $manage_git = true
# @example default $service_name
#   $service_name = 'tomcat'
# @example default $catalina_home
#   $catalina_home = '/var/lib/tomcat'
# @example default $body_text
#   $body_text = 'You can replace this block of text (in index_body.html) with some more useful
#      information about your source tree and its organization, with direct links to key parts of code base.'
# @example default $config_hash
#   $config_hash = { 'OPENGROK_VERBOSE' => 'no' }
#
class opengrok::params {
  case $::osfamily {
    'RedHat', 'Amazon': {
      $download_url = 'https://github.com/OpenGrok/OpenGrok/files/467358/opengrok-0.12.1.6.tar.gz.zip'
      $projects = {}
      $install_ctags = true
      $ctags_package = 'ctags'
      $manage_tomcat = true
      $opengrok_dir = '/opt/opengrok'
      $manage_git = true
      $service_name = 'tomcat'
      $catalina_home = '/var/lib/tomcat'
      $body_text = 'You can replace this block of text (in index_body.html) with some more useful
         information about your source tree and its organization, with direct links to key parts of code base.'
      $config_hash = { 'OPENGROK_VERBOSE' => 'no' }
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
