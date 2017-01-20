
class curator (
  Hash $actions                                            = {},
  String $ensure                                           = present,
  Boolean $manage_repository                               = true,
  Boolean $manage_user                                     = true,
  String $package_name                                     = 'elasticsearch-curator',
  String $package_provider                                 = 'pip',
  String $user_name                                        = 'curator',
  String $user_group                                       = 'users',
  Array[String] $blacklist                                 = [ 'elasticsearch', 'urllib3' ],
  Optional[String] $certificate                            = undef,
  String $config_path                                      = '/etc/curator',
  String $config_file                                      = '/etc/curator/curator.yml',
  Optional[String] $client_cert                            = undef,
  Optional[String] $client_key                             = undef,
  Array[String] $hosts                                     = [ '127.0.0.1' ],
  Optional[String] $http_auth                              = undef,
  Pattern[/^CRITICAL|ERROR|WARNING|INFO|DEBUG$/] $loglevel = 'INFO',
  Optional[String] $logfile                                = undef,
  Optional[String] $logformat                              = 'default',
  Boolean $master_only                                     = false,
  Integer $port                                            = 9200,
  String $repository_version                               = '4',
  Boolean $ssl_no_validate                                 = false,
  Integer $timeout                                         = 30,
  Optional[String] $url_prefix                             = undef,
  Boolean $use_ssl                                         = false,
) {
  contain curator::install
  contain curator::config

  if $manage_repository {
    contain curator::repository
    Class['::curator::repository'] ->
  }

  Class['::curator::install'] ->
  Class['::curator::config']
}
