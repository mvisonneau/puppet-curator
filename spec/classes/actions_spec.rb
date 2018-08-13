require 'spec_helper'

describe 'curator::actions', :type => :class do
  on_supported_os().each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      it { is_expected.to compile.with_all_deps }
      it { is_expected.to  contain_class( 'curator::install' ) }
      it { is_expected.to  contain_class( 'curator::config' ) }
    end
  end
end
