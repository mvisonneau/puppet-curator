class curator::config (
  Array[String] $blacklist                                 = $::curator::blacklist,
  Optional[String] $certificate                            = $::curator::certificate,
  String $config_path                                      = $::curator::config_path,
  String $config_file                                      = $::curator::config_file,
  Optional[String] $client_cert                            = $::curator::client_cert,
  Optional[String] $client_key                             = $::curator::client_key,
  Array[String] $hosts                                     = $::curator::hosts,
  Optional[String] $http_auth                              = $::curator::http_auth,
  Pattern[/^CRITICAL|ERROR|WARNING|INFO|DEBUG$/] $loglevel = $::curator::loglevel,
  Optional[String] $logfile                                = $::curator::logfile,
  Optional[String] $logformat                              = $::curator::logformat,
  Boolean $master_only                                     = $::curator::master_only,
  Integer $port                                            = $::curator::port,
  Boolean $ssl_no_validate                                 = $::curator::ssl_no_validate,
  Integer $timeout                                         = $::curator::timeout,
  Optional[String] $url_prefix                             = $::curator::url_prefix,
  Boolean $use_ssl                                         = $::curator::use_ssl,
) {
  require curator

  file { $config_path:
    ensure => directory,
  } ->

  file { $config_file:
    ensure  => present,
    mode    => '0660',
    content => template( 'curator.yml.erb' ),
  }
}
