class curator::repository::apt (
  String $version = $::curator::repository::version,
) inherits curator::repository {

  if ! defined( Class['::apt'] ) {
    class { '::apt': }
  }

  apt::source { 'curator':
    location => "http://packages.elastic.co/curator/${version}/debian",
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
