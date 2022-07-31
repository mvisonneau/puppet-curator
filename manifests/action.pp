# == Define: curator::action
#
# Creates a curator action
#
# === Parameters
#
define curator::action (
  String $action_mode  = $::curator::action_mode,
  String $config_path  = $::curator::config_path,
  String $config_owner = $::curator::user_name,
  String $config_group = $::curator::user_group,
  String $ensure       = present,
  Hash[
    Variant[Integer,String],
    Variant[
      Struct[{
        action      => Enum[
          'allocation',
          'close',
          'cluster_routing',
          'create_index',
          'delete_indices',
          'delete_snapshots',
          'forcemerge',
          'freeze',
          'index_settings',
          'open',
          'reindex',
          'replicas',
          'restore',
          'rollover',
          'shrink',
          'snapshot',
          'unfreeze'
        ],
        description => String,
        options     => Hash[String, Data],
        filters     => Optional[Array[Hash[String, Data]]]
      }],
      Struct[{
        action      => Enum[
          'alias',
        ],
        description => String,
        alias       => Optional[Hash[String, Data]],
        options     => Optional[Hash[String, Data]],
        add         => Optional[Hash[String, Data]],
        remove      => Hash[String, Data],
      }],
    ]
  ] $entities          = {},
) {
  require curator
  require curator::config

  file { "${config_path}/action_${name}.yml":
    ensure  => $ensure,
    owner   => $config_owner,
    group   => $config_group,
    mode    => $action_mode,
    content => hash2curatoractionfile({'actions' => $entities}),
  }
}
