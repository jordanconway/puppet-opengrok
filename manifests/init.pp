# Class: opengrok
# ===========================
#
# This is the basic class needed to install and configure an OpenGrok instance.
#
# @example Declaring the class
#   include opengrok
#
# @example Defining the opengrok::projects Hash with two git projects
#   opengrok::projects {
#     puppet-opengrok => {
#       source        => 'https://github.com/jordanconway/puppet-opengrok.git'
#       ensure        => 'latest'
#     },
#     opengrok        => {
#       source        => 'https://github.com/OpenGrok/OpenGrok.git'
#       ensure        => 'latest'
#     }
#   }
#
# @param opengrok_url Specifies the url to download the OpenGrok binaries from.
#   Valid options: A String (containing an url pointing to a .zip/tar.gz binary
#   release from https://github.com/OpenGrok/OpenGrok/releases/). Example Value:
#   'https://github.com/OpenGrok/OpenGrok/files/467358/opengrok-0.12.1.6.tar.gz.zip'.
# @param manage_git Specifies wether or not to manage git,
#   if true it will include ::git. Valid options: true, false. Example Value: true.
# @param manage_tomcat Specifies wether or not to manage tomcat,
#   if true it will include ::tomcat. Valid options: true, false. Example Value: true.
# @param service_name Specifies the service name for tomcat. Valid options: A string.
#   Example Value: tomcat
# @param install_ctags Specifies wether or not to install ctags, will install system
#  ctags package if true. Valid options: true, false. Example Value: true.
# @param ctags_package Specifies the name of the system ctags package. Valid options:
#   String of package name. Example Value: 'ctags'
# @param opengrok_dir Specifies the directory to install the OpenGrok binaries to.
#   Valid options: Absolute Path. Example Value: '/opt/opengrok'
# @param projects A hash of git projects to be served by OpenGrok.
#   This can is an alternative to defining opengrok::project types
#   Valid options: Hash
# @param catalina_home Specifies the catalina_home directory of your tomcat install, ie:
#   where the tomcat 'webapps' directory resides. Valid options: Absolute path.
#   Example Value: '/var/lib/tomcat'
#
class opengrok (

  Pattern[/^https?[^\s]*(\.zip|tar\.gz)$/] $opengrok_url = $::opengrok::params::url,
  Boolean $manage_git = $::opengrok::params::manage_git,
  Boolean $manage_tomcat = $::opengrok::params::manage_tomcat,
  String $service_name = $::opengrok::params::service_name,
  Boolean $install_ctags = $::opengrok::params::install_ctags,
  String $ctags_package = $::opengrok::params::ctags_package,
  Stdlib::Absolutepath $opengrok_dir = $::opengrok::params::opengrok_dir,
  Optional[Hash] $projects = $::opengrok::params::projects,
  Stdlib::Absolutepath $catalina_home = $::opengrok::params::catalina_home,

) inherits ::opengrok::params {

  class { '::opengrok::install': } ->
  class { '::opengrok::download': } ->
  class { '::opengrok::config': } ~>
  class { '::opengrok::service': } ->
  Class['::opengrok']

}
