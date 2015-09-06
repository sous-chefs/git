name 'git'
maintainer 'Chef Software, Inc.'
maintainer_email 'cookbooks@chef.io'
license 'Apache 2.0'
description 'Installs git and/or sets up a Git server daemon'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '4.3.4'
recipe 'git', 'Installs git'
recipe 'git::server', 'Sets up a runit_service for git daemon'
recipe 'git::source', 'Installs git from source'

supports 'amazon'
supports 'arch'
supports 'centos'
supports 'debian'
supports 'fedora'
supports 'freebsd'
supports 'mac_os_x', '>= 10.6.0'
supports 'omnios'
supports 'oracle'
supports 'redhat'
supports 'smartos'
supports 'scientific'
supports 'ubuntu'
supports 'windows'

depends 'build-essential'
depends 'dmg'
depends 'windows'
depends 'yum-epel'

source_url 'https://github.com/jssjr/git' if respond_to?(:source_url)
issues_url 'https://github.com/jssjr/git/issues' if respond_to?(:issues_url)

attribute 'git/server/base_path',
          display_name: 'Git Daemon Base Path',
          description: 'A directory containing git repositories to be ' \
            'exposed by the git-daemon',
          default: '/srv/git',
          recipes: ['git::server']

attribute 'git/server/export_all',
          display_name: 'Git Daemon Export All',
          description: 'Adds the --export-all option to the git-daemon ' \
            'parameters, making all repositories publicly readable even if ' \
            'they lack the \'git-daemon-export-ok\' file',
          choice: %w(true false),
          default: 'true',
          recipes: ['git::server']
