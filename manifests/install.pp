# Class opengrok::install
# ===========================
#
# This class is called from opengrok for install.
#
class opengrok::install(
  $manage_tomcat,
  $manage_git,
  $install_ctags,
  $ctags_package,
){

  if $manage_tomcat {
    include ::tomcat
  }
  if $manage_git {
    include ::git
  }

  if $install_ctags {
    ensure_packages([$ctags_package], {ensure => 'present'})
  }

  #setup opengrok directories
  file { '/var/opengrok/':
    ensure =>  directory,
  } ->
  file { '/var/opengrok/src':
    ensure =>  directory,
  } ->
  file { '/var/opengrok/data':
    ensure =>  directory,
  } ->
  file { '/var/opengrok/etc':
    ensure =>  directory,
  }


}
