# == Define opengrok::project

define opengrok::project (
  Enum['present', 'absent', 'latest'] $ensure = present,
  String $provider = 'git',
  String $source = undef,
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
