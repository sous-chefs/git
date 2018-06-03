#
# Author:: Jamie Winsor (<jamie@vialstudios.com>)
# Cookbook:: git
# Attributes:: default
#
# Copyright:: 2008-2016, Chef Software, Inc.
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

default['git']['version'] = '2.17.1'
default['git']['prefix'] = '/usr/local'
default['git']['url'] = 'https://nodeload.github.com/git/git/tar.gz/v%{version}'
default['git']['checksum'] = '690f12cc5691e5adaf2dd390eae6f5acce68ae0d9bd9403814f8a1433833f02a'
default['git']['use_pcre'] = false

default['git']['server']['base_path'] = '/srv/git'
default['git']['server']['export_all'] = true
