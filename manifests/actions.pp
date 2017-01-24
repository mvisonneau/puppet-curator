# == Class: curator::actions
#
# Creates action resources from a given hash
#
# === Parameters
#
class curator::actions (
  Hash $values = {},
) {
  require curator
  require curator::config

  create_resources( curator::action, $values )
}
