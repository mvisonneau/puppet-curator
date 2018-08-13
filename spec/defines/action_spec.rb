require 'spec_helper'

describe 'curator::action', :type => :define do

  on_supported_os().each do |os, os_facts|

    context "on #{os}" do
        let(:facts) { os_facts }
        let(:title) { 'test' }
        let(:params) do {
          :ensure => 'present',
          :config_path  => '/etc/curator',
          :config_owner => 'curator',
          :config_group => 'curator',
        }
        end

        it { is_expected.to  compile.with_all_deps }
        it { is_expected.to  contain_class( 'curator::install' ) }
        it { is_expected.to  contain_class( 'curator::config' ) }
        it { is_expected.to  contain_file('/etc/curator/action_test.yml').with_ensure('present') }
    end
  end

end
