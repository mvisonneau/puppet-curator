# == Class: curator::config
#
# Automatically called within the curator class
#
# Creates the configuration file for the tool
#
# === Parameters
#
class curator::config (
  Optional[String] $certificate = $::curator::certificate,
  String $config_path           = $::curator::config_path,
  String $config_path_mode      = $::curator::params::config_path_mode,
  String $config_file           = $::curator::config_file,
  String $config_file_mode      = $::curator::config_file_mode,
  Optional[String] $client_cert = $::curator::client_cert,
  Optional[String] $client_key  = $::curator::client_key,
  Array[String] $hosts          = $::curator::hosts,
  Optional[String] $http_auth   = $::curator::http_auth,
  Optional[String] $username    = $::curator::username,
  Optional[String] $password    = $::curator::password,
  Array[String] $log_blacklist  = $::curator::log_blacklist,
  Enum[
      'CRITICAL',
      'ERROR',
      'WARNING',
      'INFO',
      'DEBUG'] $log_level       = $::curator::log_level,
  Optional[String] $log_file    = $::curator::log_file,
  Optional[String] $log_format  = $::curator::log_format,
  Boolean $master_only          = $::curator::master_only,
  Integer $port                 = $::curator::port,
  Boolean $ssl_no_validate      = $::curator::ssl_no_validate,
  Integer $timeout              = $::curator::timeout,
  Optional[String] $url_prefix  = $::curator::url_prefix,
  Boolean $use_ssl              = $::curator::use_ssl,
) inherits curator {
  File {
    owner  => $::curator::user_name,
    group  => $::curator::user_group,
  }

  if $http_auth { $_http_auth_line = "http_auth: ${http_auth}" }
  if $username { $_username_line = "username: ${username}" }
  if $password { $_password_line = "password: ${password}" }
  $ssl_auth = delete_undef_values([$_http_auth_line,$_username_line,$_password_line])

  file { [$config_path,"${::curator::user_home}/.curator"]:
    ensure => directory,
    mode   => $config_path_mode,
  }

  -> file { $config_file:
    ensure  => present,
    mode    => $config_file_mode,
    content => template( "${module_name}/curator.yml.erb" ),
  }

  -> file { "${::curator::user_home}/.curator/curator.yml":
    ensure => link,
    target => $config_file,
  }
}
