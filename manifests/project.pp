# Define opengrok::project
# ===========================
#
# This define lets you add git projects to OpenGrok
#
# @example Defining a git project for OpenGrok
#   opengrok::project { 'puppet-opengrok:
#     ensure => 'latest',
#     source => 'https://github.com/jordanconway/puppet-opengrok.git',
#   }
#
# @param ensure Ensure the project is included, latest or absent. Valid Options:
#   strings 'present', 'absent', 'latest'. Example Value: 'latest'
# @param provider The vcs provider for the project. CURRENTLY ONLY SUPPORTS 'git'
#   Valid Options: String. Example Value: 'git'
# @param source A link to the git repo being added. Valid Options: String
#   Example Value: 'https://github.com/jordanconway/puppet-opengrok.git'
# @param revision A git revision reference to pin the repo to. Valid Options: String
#   Example Value: '9db36f3c12cb57bde8c2cdf4b66bf1745bea9968'
define opengrok::project (
  Pattern[/^(https?|git)[^\s]*\.git$/] $source,
  Enum['present', 'absent', 'latest'] $ensure = latest,
  Enum['git'] $provider = 'git',
  Optional[String[1]] $revision = undef,
){
  include ::opengrok::params

  vcsrepo { "/var/opengrok/src/${title}":
    ensure   => $ensure,
    provider => $provider,
    source   => $source,
    revision => $revision,
  }


}
