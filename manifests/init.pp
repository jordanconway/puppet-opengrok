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

  # Version to download from https://github.com/OpenGrok/OpenGrok/releases
  String $opengrok_url = $::opengrok::params::url,
  # Array of git repos to browse
  Boolean $manage_git = $::opengrok::params::manage_git,
  Boolean $manage_tomcat = $::opengrok::params::manage_tomcat,
  String $service_name = $::opengrok::params::service_name,
  # Array of git repos to browse
  Optional[Array[String[1]]] $git_pojects = $::opengrok::params::projects,

) inherits ::opengrok::params {

  # validate parameters here

  class { '::opengrok::install': } ->
  class { '::opengrok::download': } ->
  class { '::opengrok::config': } ~>
  class { '::opengrok::service': } ->
  Class['::opengrok']
}
