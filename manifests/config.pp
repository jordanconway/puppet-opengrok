# == Class opengrok::config
#
# This class is called from opengrok for service config.
#
class opengrok::config {

  #get sources
  $projects = $::opengrok::projects
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

  file {"${::opengrok::opengrok_dir}/bin/OpenGrok":
    ensure  => present,
    content => template('opengrok/OpenGrok.erb'),
    mode    => '0555',
  }

  #run depoloy script
  exec { 'opengrok_deploy':
    command => "${::opengrok::opengrok_dir}/bin/OpenGrok deploy",
    creates => '/var/lib/tomcat/webapps/source.war',
    require =>  File["${::opengrok::opengrok_dir}/bin/OpenGrok"],
  }

  #run index
  exec { 'opengrok_index':
    command => "${::opengrok::opengrok_dir}/bin/OpenGrok index",
    creates => '/var/opengrok/etc/configuration.xml',
    require =>  File["${::opengrok::opengrok_dir}/bin/OpenGrok"],
  }

}
