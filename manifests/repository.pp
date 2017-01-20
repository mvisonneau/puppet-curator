class curator::repository (
  String $version = $::curator::repository_version,
) inherits curator {

  case $::os['family'] {
    'Debian': {
      contain curator::repository::apt
    }
    'RedHat': {
      contain curator::repository::yum
    }
    default: {
      fail( "curator::repository does not support this OS (${::os['name']})" )
    }
  }
}
