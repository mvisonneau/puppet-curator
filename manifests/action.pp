# == Define: curator::action
#
# Creates a curator action
#
# === Parameters
#
define curator::action (
  String $config_path  = $::curator::config_path,
  String $config_owner = $::curator::user_name,
  String $config_group = $::curator::user_group,
  String $ensure       = present,
  Hash[
    Integer,
    Struct[{
      action      => Enum[
        'alias',
        'allocation',
        'close',
        'create_index',
        'delete_indices',
        'delete_snapshots',
        'forcemerge',
        'open',
        'replicas',
        'restore',
        'snapshot'
      ],
      description => String,
      options     => Hash[ String, Data],
      filters     => Array[ Hash[ String, Data ] ]
    }]
  ] $entities = {},
) {
  require curator
  require curator::config

  file { "${config_path}/action_${name}.yml":
    ensure  => $ensure,
    owner   => $config_owner,
    group   => $config_group,
    mode    => '0644',
    content => template( "${module_name}/action.yml.erb" ),
  }
}
