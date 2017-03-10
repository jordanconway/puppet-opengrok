# Class opengrok::download
# ===========================
#
# This class is called from opengrok for service download.
#
class opengrok::download(
  $download_url,
  $opengrok_dir,
){

  $opengrok_fname = get_opengrok_fname($download_url)

  if 'zip' in $opengrok_fname {
    $has_zip = true
  }  else {
    $has_zip = false
  }

  if $has_zip {
    $tarball_name = $opengrok_fname[0,-5]
  }
  else {
    $tarball_name = $opengrok_fname
  }

  $version_name = $tarball_name[0,-8]


  $install_dir = "/opt/${version_name}"

  file { $install_dir:
    ensure =>  directory,
  }

  file { $opengrok_dir:
    ensure  => link,
    target  => $install_dir,
    require => File[$install_dir],
  }

  if $has_zip {
    archive { "/tmp/${opengrok_fname}":
      ensure       => present,
      extract      => true,
      extract_path => '/tmp',
      source       => $download_url,
      creates      => "/tmp/${tarball_name}",
      cleanup      => true,
      require      => [
        File[$install_dir],
      ],
    } ->
    archive { "/tmp/${tarball_name}":
      ensure          => present,
      extract         => true,
      extract_command => 'tar xfz %s --strip-components=1',
      extract_path    => $install_dir,
      creates         => "${install_dir}/bin",
      cleanup         => true,
      require         => [
        File[$install_dir],
      ],
    }
  } else {
    archive { "/tmp/${opengrok_fname}":
      ensure          => present,
      extract         => true,
      extract_command => 'tar xfz %s --strip-components=1',
      extract_path    => $install_dir,
      source          => $download_url,
      creates         => "${install_dir}/bin",
      cleanup         => true,
      require         => [
        File[$install_dir],
      ],
    }
  }
}