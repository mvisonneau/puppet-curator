# == Define: curator::job
#
# Creates a cronjob that automates the trigger of curator::actions defined resources.
#
# === Parameters
#
define curator::job (
  String                                               $action,
  Variant[Integer[0,23],Array[Integer[0,23],Enum['*']] $hour,
  Variant[Integer[0,59],Array[Integer[0,59],Enum['*']] $minute,
  String                                               $ensure   = 'present',
  Variant[Integer[0,6],Array[Integer[0,6],Enum['*']]   $weekday  = '*',
  Variant[Integer[0,11],Array[Integer[0,11],Enum['*']] $month    = '*',
  Variant[Integer[0,30],Array[Integer[0,30],Enum['*']] $monthday = '*',
  String                                               $user     = $::curator::user_name,
) {
  require curator
  require curator::config

  cron { "curator_${name}":
    ensure   => $ensure,
    command  => "$(which curator) ${::curator::config_path}/action_${action}.yml> /dev/null 2>&1",
    hour     => $hour,
    minute   => $minute,
    month    => $month,
    monthday => $monthday,
    user     => $user,
    weekday  => $weekday,
  }
}
