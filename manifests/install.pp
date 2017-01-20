
class curator::install (
  String $ensure             = $::curator::ensure,
  Boolean $manage_repository = $::curator::manage_repository,
  Boolean $manage_user       = $::curator::manage_user,
  String $package_name       = $::curator::package_name,
  String $package_provider   = $::curator::package_provider,
  String $user_name          = $::curator::user_name,
  String $user_group         = $::curator::user_group,
) inherits curator {

  case $manage_repository {
    true: {
      require curator::repository

      case $::os['family'] {
        'Debian': {
          $_package_name     = 'python-elasticsearch-curator'
          $_package_provider = 'apt'
        }
        'RedHat': {
          $_package_name     = 'python-elasticsearch-curator'
          $_package_provider = 'yum'
        }
        default: {
          $_package_name     = 'elasticsearch-curator'
          $_package_provider = 'pip'
        }
      }
    }
    default: {
      $_package_name     = $package_name
      $_package_provider = $package_provider
    }
  }

  package { $_package_name:
    ensure   => $ensure,
    provider => $_package_provider,
  }

  if $manage_user {
    user { $user_name:
      gid => $user_group,
    }
  }
}
