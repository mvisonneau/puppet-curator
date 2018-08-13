# == Class: curator
#
# Main class that needs to be included to your manifests in order to install
# the tool.
#
# === Parameters
#
class curator (
  String $ensure                = present,
  Optional[String] $certificate = undef,
  String $command               = '$(which curator)',
  Optional[String] $client_cert = undef,
  Optional[String] $client_key  = undef,
  String $config_path           = '/etc/curator',
  String $config_file           = '/etc/curator/curator.yml',
  Array[String] $hosts          = [ '127.0.0.1' ],
  Optional[String] $http_auth   = undef,
  Array[String] $log_blacklist  = [ 'elasticsearch', 'urllib3' ],
  Enum[
      'CRITICAL',
      'ERROR',
      'WARNING',
      'INFO',
      'DEBUG'] $log_level       = 'INFO',
  Optional[String] $log_file    = undef,
  Optional[String] $log_format  = 'default',
  Boolean $manage_repository    = true,
  Boolean $manage_user          = true,
  Boolean $master_only          = false,
  String $package_name          = 'elasticsearch-curator',
  String $package_provider      = 'pip',
  Integer $port                 = 9200,
  String $repository_version    = '4',
  Boolean $ssl_no_validate      = false,
  Integer $timeout              = 30,
  Optional[String] $url_prefix  = undef,
  Boolean $use_ssl              = false,
  String $user_name             = 'curator',
  String $user_group            = 'users',
  String $user_home             = '/home/curator',
) {
  contain curator::install
  contain curator::config

  if $manage_repository {
    contain curator::repository
    Class['::curator::repository']
    -> Class['::curator::install']
  }

  Class['::curator::install']
  -> Class['::curator::config']
}
