# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [v1.0.8] - 2022-03-01
### CHANGED

- Added support for latest versions of Debian & Ubuntu
- Support Puppet >= 7
- Gracefully handle unsupported OSes [GH-18]
- Replaced Travis which has now shutdown with GH actions
- Fixed missing dependency over puppetlabs/yumrepo_core` module

## [v1.0.7] - 2019-03-12
### FEATURES

- Added support for Debian Stretch [GH-17]

### BUGFIXES

- Fixed Travis CI pipeline [GH-17]

## [v1.0.6] - 2018-08-13
### ENHANCEMENTS

- Added the possibility to configure the path of the curator command [GH-5]
- Lint improvements
- Additional testing use cases [GH-11]

### BUGFIXES

- Updated parameter types on jobs in order to support more configs [GH-8]
- Fixed support for alias and added support for cluster_routing, index_settings, reindex, rollover and shrink actions [GH-7]

## [v1.0.5] - 2018-07-13
### ENHANCEMENTS

- Support of unquoted booleans within curator config [GH-6]

## [v1.0.4] - 2018-01-30
### ENHANCEMENTS

- Added CHANGELOG.md
- Reverted String to Integer as Hash keys for the config

### BUGFIXES

- Fixed broken Debian CI rspec tests

## [v1.0.3] - 2017-09-15
### BUGFIXES

- Update action.pp [GH-1]

## [v1.0.2] - 2017-01-24
### ENHANCEMENTS

- Updated actions and jobs definitions

## [v1.0.1] - 2017-01-20
### FEATURES

- Init

[Unreleased]: https://github.com/mvisonneau/puppet-curator/compare/v1.0.8...HEAD
[v1.0.8]: https://github.com/mvisonneau/puppet-curator/compare/v1.0.7...v1.0.8
[v1.0.7]: https://github.com/mvisonneau/puppet-curator/compare/v1.0.6...v1.0.7
[v1.0.6]: https://github.com/mvisonneau/puppet-curator/compare/v1.0.5...v1.0.6
[v1.0.5]: https://github.com/mvisonneau/puppet-curator/compare/v1.0.4...v1.0.5
[v1.0.4]: https://github.com/mvisonneau/puppet-curator/compare/v1.0.3...v1.0.4
[v1.0.3]: https://github.com/mvisonneau/puppet-curator/compare/v1.0.2...v1.0.3
[v1.0.2]: https://github.com/mvisonneau/puppet-curator/compare/v1.0.1...v1.0.2
[v1.0.1]: https://github.com/mvisonneau/puppet-curator/tree/v1.0.1
