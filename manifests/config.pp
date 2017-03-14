# Class opengrok::config
# ===========================
#
# This class is called from opengrok for service config.
#
# @param opengrok_dir Specifies the directory to install the OpenGrok binaries to.
#   Valid options: Absolute Path. Example Value: '/opt/opengrok'
# @param projects A hash of git projects to be served by OpenGrok.
#   This can is an alternative to defining opengrok::project types
#   Valid options: Hash
# @param catalina_home Specifies the catalina_home directory of your tomcat install, ie:
#   where the tomcat 'webapps' directory resides. Valid options: Absolute path.
#   Example Value: '/var/lib/tomcat'
#
class opengrok::config (
  $projects,
  $opengrok_dir,
  $catalina_home,
){

  #get sources
  if is_hash($projects) {
    $projects.each |$resource, $options| {
      ::opengrok::project { $resource:
        *       => $options,
        notify  => Exec['opengrok_index'],
        require => Exec['opengrok_deploy'],
      }
    }
  }

  #fix opengrok scipt

  file {"${opengrok_dir}/bin/OpenGrok":
    ensure  => present,
    content => template('opengrok/OpenGrok.erb'),
    mode    => '0555',
  }

  #run depoloy script
  exec { 'opengrok_deploy':
    command => "${opengrok_dir}/bin/OpenGrok deploy",
    creates => '/var/lib/tomcat/webapps/source.war',
    require =>  File["${opengrok_dir}/bin/OpenGrok"],
  }

  #run index
  exec { 'opengrok_index':
    command => "${opengrok_dir}/bin/OpenGrok index",
    creates => '/var/opengrok/etc/configuration.xml',
    require =>  File["${opengrok_dir}/bin/OpenGrok"],
  }

}
