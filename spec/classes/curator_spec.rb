require 'spec_helper'

describe 'curator' do

  context 'with default configuration on Debian' do
    let :facts do {
      :lsbdistid     => 'Debian',
      :osfamily      => 'Debian',
      :os            => { :family  => 'Debian' },
      :puppetversion => '4.8.2'
    }
    end

    it { should compile.with_all_deps }
    it { should contain_class( 'curator::install' ) }
    it { should contain_class( 'curator::config' ) }
    it { should contain_class( 'curator::repository' ) }
    it { should contain_class( 'curator::repository::apt' ) }
    it { should_not contain_class( 'curator::repository::yum' ) }
  end

  context 'with manage_repository=false on Debian' do
    let :params do {
      :manage_repository => false,
    }
    end

    let :facts do {
      :lsbdistid     => 'Debian',
      :osfamily      => 'Debian',
      :os            => { :family  => 'Debian' },
      :puppetversion => '4.8.2'
    }
    end

    it { should compile.with_all_deps }
    it { should contain_class( 'curator::install' ) }
    it { should contain_class( 'curator::config' ) }
    it { should_not contain_class( 'curator::repository' ) }
    it { should_not contain_class( 'curator::repository::apt' ) }
    it { should_not contain_class( 'curator::repository::yum' ) }
  end

  context 'with default configuration on RedHat' do
    let :facts do {
      :os => {
        :family  => 'RedHat',
        :release => {
          :major => '7'
        }
       }
    }
    end

    it { should compile.with_all_deps }
    it { should contain_class( 'curator::install' ) }
    it { should contain_class( 'curator::config' ) }
    it { should contain_class( 'curator::repository' ) }
    it { should_not contain_class( 'curator::repository::apt' ) }
    it { should contain_class( 'curator::repository::yum' ) }
  end

  context 'with manage_repository=false on RedHat' do
    let :params do {
      :manage_repository => false,
    }
    end

    let :facts do {
      :os => {
        :family  => 'RedHat',
        :release => {
          :major => '7'
        }
       }
    }
    end

    it { should compile.with_all_deps }
    it { should contain_class( 'curator::install' ) }
    it { should contain_class( 'curator::config' ) }
    it { should_not contain_class( 'curator::repository' ) }
    it { should_not contain_class( 'curator::repository::apt' ) }
    it { should_not contain_class( 'curator::repository::yum' ) }
  end
end
