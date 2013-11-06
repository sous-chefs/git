#
# Author:: Jamie Winsor (<jamie@vialstudios.com>)
# Cookbook Name:: git
# Attributes:: default
#
# Copyright 2008-2012, Opscode, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

case node['platform_family']
when 'windows'
  default['git']['version'] = "1.8.4-preview20130916"
  default['git']['url'] = "https://msysgit.googlecode.com/files/Git-#{node['git']['version']}.exe"
  default['git']['checksum'] = "c509c7ce1b9a4f752f783cb33293f9b2cb42346d60648568e338fc7db207a98f"
  default['git']['display_name'] = "Git version #{ node['git']['version'] }"
when "mac_os_x"
  default['git']['osx_dmg']['app_name']    = "git-1.8.4.2-intel-universal-snow-leopard"
  default['git']['osx_dmg']['volumes_dir'] = "Git 1.8.4.2 Snow Leopard Intel Universal"
  default['git']['osx_dmg']['package_id']  = "GitOSX.Installer.git1842.git.pkg"
  default['git']['osx_dmg']['url']         = "https://git-osx-installer.googlecode.com/files/#{node['osx_dmg']['app_name']}.dmg"
  default['git']['osx_dmg']['checksum']    = "09de334f03f653b96c12619f592010231c39389acd1781e3fdf0651bc6afd132"
else
  default['git']['prefix'] = "/usr/local"
  default['git']['version'] = "1.8.4.2"
  default['git']['url'] = "https://nodeload.github.com/git/git/tar.gz/v#{node['git']['version']}"
  default['git']['checksum'] = "3139c199e6d1baf20aad392bf3a311c0bf5e7fa55a1c81780f2f87986258fdb6"
end

default['git']['server']['base_path'] = "/srv/git"
default['git']['server']['export_all'] = "true"
