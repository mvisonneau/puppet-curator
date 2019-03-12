# == Class: curator::repository::apt
#
# Private class included if $manage_repository is true and if the os family is debian.
#
# === Parameters
#
class curator::repository::apt (
  String $debian_major_version = $::os['release']['major'],
  String $version = $::curator::repository::version,
) inherits curator::repository {

  if ! defined( Class['::apt'] ) {
    class { '::apt': }
  }

  $repo_suffix = $debian_major_version ? {
    '9'     => '9', # Debian 9 ships with OpenSSL 1.1.0
    default => '',
  }

  apt::source { 'curator':
    location => "http://packages.elastic.co/curator/${version}/debian${repo_suffix}",
    release  => 'stable',
    repos    => 'main',
    key      => {
      id     => '46095ACC8548582C1A2699A9D27D666CD88E42B4',
      server => 'pgp.mit.edu'
    },
    include  => {
      src => false,
      deb => true,
    }
  }
}
