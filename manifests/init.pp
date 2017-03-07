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
  Boolean $install_ctags = $::opengrok::params::install_ctags,
  String $ctags_package = $::opengrok::params::ctags_package,
  String $opengrok_dir = $::opengrok::params::opengrok_dir,
  # Array of git repos to browse
  Optional[Hash] $git_pojects = $::opengrok::params::projects,

) inherits ::opengrok::params {

  # validate parameters here

  class { '::opengrok::install': } ->
  class { '::opengrok::download': } ->
  class { '::opengrok::config': } ~>
  class { '::opengrok::service': } ->
  Class['::opengrok']
}
