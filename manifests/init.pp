# == Class: curator
#
# Main class that needs to be included to your manifests in order to install
# the tool.
#
# === Parameters
#
class curator (
  String $ensure                 = $::curator::params::ensure,
  String $action_mode            = $::curator::params::action_mode,
  String $command                = $::curator::params::command,
  String $config_path            = $::curator::params::config_path,
  String $config_path_mode       = $::curator::params::config_path_mode,
  String $config_file            = $::curator::params::config_file,
  String $config_file_mode       = $::curator::params::config_file_mode,
  Array[String] $hosts           = $::curator::params::hosts,
  Array[String] $log_blacklist   = $::curator::params::log_blacklist,
  Enum[
    'CRITICAL',
    'ERROR',
    'WARNING',
    'INFO',
    'DEBUG' ]   $log_level       = $::curator::params::log_level,
  Boolean $manage_repository     = $::curator::params::manage_repository,
  Boolean $manage_user           = $::curator::params::manage_user,
  Boolean $master_only           = $::curator::params::master_only,
  String $package_provider       = $::curator::params::package_provider,
  Integer $port                  = $::curator::params::port,
  String $repository_version     = $::curator::params::repository_version,
  Boolean $ssl_no_validate       = $::curator::params::ssl_no_validate,
  Integer $timeout               = $::curator::params::timeout,
  Boolean $use_ssl               = $::curator::params::use_ssl,
  String $user_name              = $::curator::params::user_name,
  String $user_group             = $::curator::params::user_group,
  String $user_home              = $::curator::params::user_home,

  Optional[String] $http_auth    = $::curator::params::http_auth,
  Optional[String] $username     = $::curator::params::username,
  Optional[String] $password     = $::curator::params::password,
  Optional[String] $log_file     = $::curator::params::log_file,
  Optional[String] $log_format   = $::curator::params::log_format,
  Optional[String] $package_name = $::curator::params::package_name,
  Optional[String] $url_prefix   = $::curator::params::url_prefix,
  Optional[String] $certificate  = $::curator::params::certificate,
  Optional[String] $client_cert  = $::curator::params::client_cert,
  Optional[String] $client_key   = $::curator::params::client_key,
) inherits curator::params {
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
