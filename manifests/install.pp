# Class opengrok::install
# ===========================
#
# This class is called from opengrok for install.
#
# @param manage_git Specifies wether or not to manage git,
#   if true it will include ::git. Valid options: true, false. Example Value: true.
# @param manage_tomcat Specifies wether or not to manage tomcat,
#   if true it will include ::tomcat. Valid options: true, false. Example Value: true.
# @param install_ctags Specifies wether or not to install ctags, will install system
#  ctags package if true. Valid options: true, false. Example Value: true.
# @param ctags_package Specifies the name of the system ctags package. Valid options:
#   String of package name. Example Value: 'ctags'
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
