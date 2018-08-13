require 'spec_helper'

describe 'param_host.example.com', :type => :host do

  on_supported_os().each do |os, os_facts|

    context "on #{os}" do
      let(:facts) { os_facts }

      it { is_expected.to compile.with_all_deps }
      it { is_expected.to contain_class( 'curator' ) }
      it { is_expected.to contain_class( 'curator::install' ) }
      it { is_expected.to contain_class( 'curator::config' ) }
      it { is_expected.to contain_class( 'curator::repository' ) }

      it { is_expected.to contain_file('/etc/curator') }
      it { is_expected.to contain_file('/home/curator/.curator') }
      it { is_expected.to contain_file('/etc/curator/curator.yml') }
      it { is_expected.to contain_file('/home/curator/.curator/curator.yml') }

      it { is_expected.to contain_curator__action('param_action_1') }
      it { is_expected.to contain_curator__job('param_job_1') }
      it { is_expected.to contain_file('/etc/curator/action_param_action_1.yml') }
      it { is_expected.to contain_cron('curator_param_job_1') }


    end
  end
end
