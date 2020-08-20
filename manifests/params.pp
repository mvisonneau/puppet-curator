# == Class curator::params
#
# This class is meant to be called from curator
# It sets variables according to platform
class curator::params{
  $action_mode          = '0644'
  $certificate          = undef
  $client_cert          = undef
  $client_key           = undef
  $command              = '$(which curator)'
  $config_file          = '/etc/curator/curator.yml'
  $config_file_mode     = '0660'
  $config_path          = '/etc/curator'
  $config_path_mode     = '0755'
  $ensure               = 'present'
  $hosts                = [ '127.0.0.1' ]
  $http_auth            = undef
  $log_blacklist        = [ 'elasticsearch', 'urllib3' ]
  $log_file             = undef
  $log_format           = 'default'
  $log_level            = 'INFO'
  $manage_repository    = true
  $manage_user          = true
  $master_only          = false
  $port                 = 9200
  $repository_version   = '5'
  $ssl_no_validate      = false
  $timeout              = 30
  $url_prefix           = undef
  $user_group           = 'users'
  $user_home            = '/home/curator'
  $user_name            = 'curator'
  $use_ssl              = false



  case $::os['family'] {
    'Debian': {
      $package_name     = 'elasticsearch-curator'
      $package_provider = 'apt'
    }
    'RedHat': {
      $package_name     = 'elasticsearch-curator'
      $package_provider = 'yum'
    }
    default: {
      $package_name     = 'elasticsearch-curator'
      $package_provider = 'pip'
    }
  }



}
