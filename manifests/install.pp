# == Class opengrok::install
#
# This class is called from opengrok for install.
#
class opengrok::install {

  package { $::opengrok::package_name:
    ensure => present,
  }
}
