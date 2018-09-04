# == Class: curator::install
#
# Automatically called within the curator class
#
# Handles the installation of the tool.
#
# === Parameters
#
class curator::install{

  if ($::curator::manage_repository) {
    require curator::repository
  }

  package { $::curator::package_name:
    ensure   => $::curator::ensure,
    provider => $::curator::package_provider,
  }

  if $::curator::manage_user {
    user { $::curator::user_name:
      gid        => $::curator::user_group,
      home       => $::curator::user_home,
      managehome => true,
    }
  }
}
