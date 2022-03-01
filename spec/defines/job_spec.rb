require 'spec_helper'

describe 'curator::job', :type => :define do

  on_supported_os().each do |os, os_facts|

    context "on #{os}" do
        let(:facts) { os_facts }
        let(:title) { 'job_1' }
        let(:params) do {
          :ensure  => 'present',
          :action  => 'action_test',
          :user    => 'curator',
          :hour    => 1,
          :minute  => 15,
          :weekday => '*',
        }
        end

        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_class( 'curator::install' ) }
        it { is_expected.to contain_class( 'curator::config' ) }
        it { is_expected.to contain_cron__job( 'curator_job_1') }
    end

  end
end
