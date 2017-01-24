# == Class: curator::jobs
#
# Creates job resources from a given hash
#
# === Parameters
#
class curator::jobs (
  Hash $values = {},
) {
  require curator
  require curator::config

  create_resources( curator::job, $values )
}
