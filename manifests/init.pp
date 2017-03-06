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
  $opengrok_version = $::opengrok::params::version,
  # Array of git repos to browse
  $manage_git = $::opengrok::params::manage_git,
  $manage_tomcat = $::opengrok::params::manage_tomcat,
  # Array of git repos to browse
  $git_pojects = $::opengrok::params::projects,

) inherits ::opengrok::params {

  # validate parameters here

  class { '::opengrok::install': } ->
  class { '::opengrok::download': } ->
  class { '::opengrok::config': } ~>
  class { '::opengrok::service': } ->
  Class['::opengrok']
}
