name              "git"
maintainer        "Opscode, Inc."
maintainer_email  "cookbooks@opscode.com"
license           "Apache 2.0"
description       "Installs git and/or sets up a Git server daemon"
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           "1.0.3"
recipe            "git", "Installs git"
recipe            "git::server", "Sets up a runit_service for git daemon"
recipe            "git::source", "Installs git from source"

%w{ amazon arch centos debian fedora redhat scientific ubuntu windows }.each do |os|
  supports os
end

supports "mac_os_x", ">= 10.6.0"

case node['platform_family']
when 'mac_os_x'
  depends 'dmg'
when 'debian'
  depends 'runit'
  depends 'build-essential'
when 'rhel', 'fedora'
  depends 'yum'
  depends 'build-essential'
when 'windows'
  depends 'windows'
end
