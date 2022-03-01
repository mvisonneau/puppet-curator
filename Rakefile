require 'puppet_blacksmith/rake_tasks'
require 'puppet-lint/tasks/puppet-lint'
require 'puppetlabs_spec_helper/rake_tasks'
require 'metadata-json-lint/rake_task'

## PUPPETLINT CONFIGURATION
Rake::Task[:lint].clear
PuppetLint::RakeTask.new :lint do |config|
  config.disable_checks = []
end

desc "Prep config package for spec testing"
task :spec_prep do
   options = { verbose: true, force: true }

   site='./spec/fixtures/manifests/site.pp'
   File.delete(site) if File.exist?(site)
   symlink('../../../examples/site.pp', site , options )

   File.delete('./spec/fixtures/hiera.yaml') if File.symlink?('./spec/fixtures/hiera.yaml')
   symlink('../../examples/hiera.yaml', './spec/fixtures/hiera.yaml', options )

   File.delete('./spec/fixtures/hieradata') if File.symlink?('./spec/fixtures/hieradata')
   symlink('../../examples/hieradata/', './spec/fixtures/hieradata', options )
end

#########################################################################
# Define rake runs collection of tasks
#########################################################################
# :spec expands to :spec_prep , :spec_standalone , :spec_clean
desc "Run syntax validation , puppet unit tests"
task :test => [:syntax, :spec, :lint , :metadata_lint ]

# Aliases of tasks
desc "Alias for spec_standalone"
task :spec_test => [:spec_standalone]
