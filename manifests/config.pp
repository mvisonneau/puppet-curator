# == Class: curator::config
#
# Automatically called within the curator class
#
# Creates the configuration file for the tool
#
# === Parameters
#
class curator::config (
  Optional[String] $certificate                             = $::curator::certificate,
  String $config_path                                       = $::curator::config_path,
  String $config_file                                       = $::curator::config_file,
  Optional[String] $client_cert                             = $::curator::client_cert,
  Optional[String] $client_key                              = $::curator::client_key,
  Array[String] $hosts                                      = $::curator::hosts,
  Optional[String] $http_auth                               = $::curator::http_auth,
  Array[String] $log_blacklist                              = $::curator::log_blacklist,
  Pattern[/^CRITICAL|ERROR|WARNING|INFO|DEBUG$/] $log_level = $::curator::log_level,
  Optional[String] $log_file                                = $::curator::log_file,
  Optional[String] $log_format                              = $::curator::log_format,
  Boolean $master_only                                      = $::curator::master_only,
  Integer $port                                             = $::curator::port,
  Boolean $ssl_no_validate                                  = $::curator::ssl_no_validate,
  Integer $timeout                                          = $::curator::timeout,
  Optional[String] $url_prefix                              = $::curator::url_prefix,
  Boolean $use_ssl                                          = $::curator::use_ssl,
) inherits curator {
  File {
    owner  => $::curator::user_name,
    group  => $::curator::user_group,
    mode   => '0644',
  }

  file { [ $config_path, "${::curator::user_home}/.curator" ]:
    ensure => directory,
  } ->

  file { $config_file:
    ensure  => present,
    mode    => '0660',
    content => template( "${module_name}/curator.yml.erb" ),
  } ->

  file { "${::curator::user_home}/.curator/curator.yml":
    ensure => link,
    target => $config_file,
  }
}
