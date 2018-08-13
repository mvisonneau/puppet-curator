require 'spec_helper'

describe 'hiera_host.example.com', :type => :host do

  on_supported_os().each do |os, os_facts|

    context "on #{os}" do
      let(:facts) { os_facts }

#    context "on " do
#      include_context 'enable_hiera'
#      include_context 'print_catalogue'
#      include_context 'debug_mode'
#      let(:facts) { on_supported_os['redhat-7-x86_64'] }

      it { is_expected.to compile.with_all_deps }
      it { is_expected.to contain_class( 'curator' ) }
      it { is_expected.to contain_class( 'curator::install' ) }
      it { is_expected.to contain_class( 'curator::config' ) }
      it { is_expected.to contain_class( 'curator::repository' ) }

      it { is_expected.to contain_file('/etc/curator') }
      it { is_expected.to contain_file('/home/curator/.curator') }
      it { is_expected.to contain_file('/etc/curator/curator.yml') }
      it { is_expected.to contain_file('/home/curator/.curator/curator.yml') }

      it { is_expected.to contain_class( 'curator::actions' ) }
      it { is_expected.to contain_class('curator::jobs' ) }

      it { is_expected.to contain_curator__action('hiera_action_1') }
      it { is_expected.to contain_curator__job('hiera_job_1') }
      it { is_expected.to contain_file('/etc/curator/action_hiera_action_1.yml') }
      it { is_expected.to contain_cron('curator_hiera_job_1') }

    end
  end
end
