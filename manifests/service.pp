# == Class opengrok::service
#
# This class is meant to be called from opengrok.
# It ensure the service is running.
#
class opengrok::service {

  service { $::opengrok::service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
