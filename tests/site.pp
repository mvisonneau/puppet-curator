node 'hiera_host.example.com' {
  include curator
  include ::curator::actions
  include ::curator::jobs
}

node 'param_host.example.com' {
  include curator

  curator::action { 'param_action_1':
    entities => {
      'action_1' => {
        'action' => 'delete_indices',
        'description' => 'Delete indices older than 45 days (based on index name)',
        'options' => {
          'continue_if_exception' => 'True',
          'disable_action'        => 'False',
          'ignore_empty_list'     => 'True',
        },
        'filters' => [
          {
            'filtertype' => 'pattern',
            'kind'       => 'prefix',
            'value'      => 'logstash-',
          },
          {
            'filtertype' => 'age',
            'source'     => 'name',
            'direction'  => 'older',
            'timestring' => '%Y.%m.%d',
            'unit'       => 'days',
            'unit_count' => '45',
          },
        ],
      },
    },
  }

  curator::job { 'param_job_1':
    action => 'purge_logstash_over_45_days',
    minute => 0,
    hour   => 0,
  }

}

node default {}
