# == Class: curator::repository
#
# Automatically called within the curator class by default but can be removed
# setting $manage_repository to false
#
# Handles the installation of the repository accordingly to the os type
#
# === Parameters
#
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
