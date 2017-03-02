# Class: opengrok
# ===========================
#
# Full description of class opengrok here.
#
# Parameters
# ----------
#
# * `sample parameter`
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
class opengrok (
  $package_name = $::opengrok::params::package_name,
  $service_name = $::opengrok::params::service_name,
) inherits ::opengrok::params {

  # validate parameters here

  class { '::opengrok::install': } ->
  class { '::opengrok::config': } ~>
  class { '::opengrok::service': } ->
  Class['::opengrok']
}
