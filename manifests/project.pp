# == Define opengrok::project

define opengrok::project (
  Enum['present', 'absent', 'latest'] $ensure = present,
  String $provider = 'git',
  String $source = undef,
  String $revision = undef,
){
  include ::vcsrepo
  include ::opengrok::params

  vcsrepo { "/var/opengrok/src/${title}":
    ensure   => $ensure,
    provider => $provider,
    source   => $source,
    revision => $revision,
  }


}
