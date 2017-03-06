# == Class opengrok::install
#
# This class is called from opengrok for install.
#
class opengrok::install {

  if $::manage_tomcat {
    include ::tomcat

    tomcat::install {'tomcat':
        install_from_source => false,
        package_name        => 'tomcat',
        notify              => Service['tomcat'],
    }
    tomcat::install {'tomcat':
        install_from_source => false,
        package_name        => 'tomcat',
        notify              => Service['tomcat'],
    }
  }
  if $::manage_git {
    include ::git
  }


  #Install Gem prerequisites
  $gems = ['httparty','nokogiri']
  ensure_packages($gems, {'ensure' => 'present'})

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
