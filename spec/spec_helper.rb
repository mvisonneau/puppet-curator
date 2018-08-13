# Set mock to rspec
RSpec.configure do |c|
  # https://github.com/puppetlabs/puppetlabs_spec_helper#mock_with
  c.mock_with :rspec
  c.mock_framework = :rspec
end
require 'puppetlabs_spec_helper/module_spec_helper'
require 'rspec-puppet-facts'
include RspecPuppetFacts

default_facts = {
  puppetversion: Puppet.version,
  facterversion: Facter.version,
}

hiera_config = File.join(File.expand_path(File.dirname(__FILE__)),'fixtures','hiera.yaml')

RSpec.configure do |c|
    c.default_facts = default_facts

    # Readable test descriptions
    c.color = true
    c.tty = true
    # To see test in details
    #c.formatter = :documentation

    c.ordering = :manifest

    c.hiera_config = hiera_config
end

# Use context by doing include_context "name"
# This will load hiera files located in tests/hieradata
shared_context "enable_hiera" do
  let(:hiera_config) { hiera_config }
end

shared_context 'single_fact_family' do
  let(:facts) { on_supported_os['redhat-7-x86_64'] }
end

# See what puppet is doing by setting Debug Mode to Console
shared_context "debug_mode" do
  Puppet::Util::Log.level = :debug
  Puppet::Util::Log.newdestination(:console)
end

# This allows you to dump all catalog objects
# To print individual resource
# it { p catalogue.resource('File','foo')}
# OR
# require 'pp'
# it { pp catalogue.resource('File','foo')}
#
#  Another ways to dump catalog ,
# # require 'json'
# # it { puts JSON.pretty_generate(JSON.parse(catalogue.resources.to_json)) }
# # it { puts JSON.pretty_generate(JSON.parse(catalogue.resource('File','foo').to_json)) }
# # it {
# #    ob=(JSON.parse(catalogue.resource('File','/etc/gitlab/gitlab.rb').to_json))
# #    puts ob['parameters']['content']
# # }
# ## write it to File
# # require 'json'
# # it { File.write('output.json', JSON.pretty_generate(JSON.parse(catalogue.resources.to_json))) }
# # it { File.write('output.json', JSON.pretty_generate(JSON.parse(catalogue.resource('File','foo').to_json))) }
# #
shared_context "print_catalogue" do
  require 'json'
  it {
      JSON.parse(catalogue.resources.to_json).each do |ob|
          puts "#{ob['type']}::#{ob['title']}"
      end
  }
end

shared_context "print_catalogue_verbose" do
    it { pp catalogue.resources }
end

# In contrast to printing entire catalogue
# modify this context or create our own to make it easier to pint catalogue info
shared_context "print_catalogue_classes" do
  require 'json'
  it {
      JSON.parse(catalogue.resources.to_json).each do |ob|
          if ob['type'] == "Class"
            puts "#{ob['type']}::#{ob['title']}"
          end
      end
  }
end

shared_context "print_catalogue_files" do
  require 'json'
  it {
      JSON.parse(catalogue.resources.to_json).each do |ob|
          if ob['type'] == "File"
            puts "#{ob['type']}::#{ob['title']}"
          end
      end
  }
end

shared_context "print_catalogue_services" do
  require 'json'
  it {
      JSON.parse(catalogue.resources.to_json).each do |ob|
          if ob['type'] == "Service"
            puts "#{ob['type']}::#{ob['title']}"
          end
      end
  }
end
