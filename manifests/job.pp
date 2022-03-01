# == Define: curator::job
#
# Creates a cronjob that automates the trigger of curator::actions defined resources.
#
# === Parameters
#
define curator::job (
  String                                                $action,
  Variant[Integer[0,59],Array[Integer[0,59]],Enum['*']] $minute,
  Variant[Integer[0,23],Array[Integer[0,23]],Enum['*']] $hour,
  Variant[Integer[0,30],Array[Integer[0,30]],Enum['*']] $date    = '*',
  Variant[Integer[0,11],Array[Integer[0,11]],Enum['*']] $month   = '*',
  String                                                $user    = $::curator::user_name,
  Variant[Integer[0,6],Array[Integer[0,6]],Enum['*']]   $weekday = '*',
  String                                                $ensure  = 'present',
) {
  require curator
  require curator::config
  require cron

  cron::job { "curator_${name}":
    ensure  => $ensure,
    minute  => $minute,
    hour    => $hour,
    date    => $date,
    month   => $month,
    weekday => $weekday,
    user    => $user,
    command => "${::curator::command} ${::curator::config_path}/action_${action}.yml> /dev/null 2>&1",
  }
}
