name 'git'
maintainer 'Chef Software, Inc.'
maintainer_email 'cookbooks@chef.io'
license 'Apache-2.0'
description 'Installs git and/or sets up a Git server daemon'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '8.0.0'
recipe 'git', 'Installs git'
recipe 'git::server', 'Sets up a a git daemon'
recipe 'git::source', 'Installs git from source'

%w( amazon centos fedora freebsd debian omnios oracle mac_os_x redhat scientific smartos suse opensuse opensuseleap ubuntu windows ).each do |os|
  supports os
end

depends 'build-essential'
depends 'homebrew'

source_url 'https://github.com/chef-cookbooks/git'
issues_url 'https://github.com/chef-cookbooks/git/issues'
chef_version '>= 12.7' if respond_to?(:chef_version)
