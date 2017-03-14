# Class opengrok::service
# ===========================
#
# This class is meant to be called from opengrok.
# It ensure the service is running.
#
# @param service_name Specifies the service name for tomcat. Valid options: A string.
#   Example Value: tomcat
#
class opengrok::service(
  $service_name,
){

  service { $service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
