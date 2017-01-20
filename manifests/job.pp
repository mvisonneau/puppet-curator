# == Define: curator::job
#
# Creates a cronjob that automates the trigger of curator::actions defined resources.
#
# === Parameters
#
define curator::job (
  String $action,
  String $hour,
  String $minute,
  String $ensure   = present,
  String $weekday  = '*',
  String $month    = '*',
  String $monthday = '*',
  String $user     = $::curator::user_name,
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
