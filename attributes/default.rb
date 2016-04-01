#
# Author:: Jamie Winsor (<jamie@vialstudios.com>)
# Cookbook Name:: git
# Attributes:: default
#
# Copyright 2008-2016, Chef Software, Inc.
#
# Licensed under the Apache License, Version 2.0 (the 'License');
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an 'AS IS' BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

case node['platform_family']
when 'windows'
  default['git']['version'] = '2.7.4'
  if node['kernel']['machine'] == 'x86_64'
    default['git']['architecture'] = '64'
    default['git']['checksum'] = '1290afb22f2441ce85f8f6f1a94c06768ca470dc18113a83ef6a4cefc16c2381'
  else
    default['git']['architecture'] = '32'
    default['git']['checksum'] = '49601d5102df249d6f866ecfa1eea68eb5672acc1dbb7e4051099e792f6da5fc'
  end
  default['git']['url'] = 'https://github.com/git-for-windows/git/releases/download/v%{version}.windows.1/Git-%{version}-%{architecture}-bit.exe'
  default['git']['display_name'] = "Git version #{node['git']['version']}"
when 'mac_os_x'
  default['git']['osx_dmg']['app_name']    = 'git-2.7.1-intel-universal-mavericks'
  default['git']['osx_dmg']['volumes_dir'] = 'Git 2.7.1 Mavericks Intel Universal'
  default['git']['osx_dmg']['package_id']  = 'GitOSX.Installer.git195Universal.git.pkg'
  default['git']['osx_dmg']['url']         = 'http://sourceforge.net/projects/git-osx-installer/files/git-2.7.1-intel-universal-maverick.dmg/download'
  default['git']['osx_dmg']['checksum']    = '260b32e8877eb72d07807b26163aeec42e2d98c350f32051ab1ff0cc33626440'
else
  default['git']['prefix'] = '/usr/local'
  default['git']['version'] = '2.7.4'
  default['git']['url'] = 'https://nodeload.github.com/git/git/tar.gz/v%{version}'
  default['git']['checksum'] = '8d53703d75890c03e26a915c7af3b7b98d8cfb94382f685a9bcbee1eeaec47b4'
  default['git']['use_pcre'] = false
end

default['git']['server']['base_path'] = '/srv/git'
default['git']['server']['export_all'] = true
