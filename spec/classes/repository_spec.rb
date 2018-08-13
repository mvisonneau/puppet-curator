require 'spec_helper'

describe 'curator::repository', :type => :class do

  on_supported_os().each do |os, os_facts|

    context "on #{os}" do
      let(:facts) { os_facts }

      let(:params) do {
        :version => '5',
      }
      end

      it { is_expected.to compile.with_all_deps }
      it { is_expected.to contain_class( 'curator' ) }
      it { is_expected.to contain_class( 'curator::install' ) }
      it { is_expected.to contain_class( 'curator::config' ) }
      it { is_expected.to contain_class( 'curator::repository' ) }

      if os_facts[:osfamily] == 'RedHat'
        it { is_expected.to     contain_class( 'curator::repository::yum' ) }
        it { is_expected.not_to contain_class( 'curator::repository::apt' ) }
      end

      if os_facts[:osfamily] == 'Debian'
        it { is_expected.not_to contain_class( 'curator::repository::yum' ) }
        it { is_expected.to     contain_class( 'curator::repository::apt' ) }
      end


    end
  end
end
