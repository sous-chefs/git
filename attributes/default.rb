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

default[:git][:osx_dmg][:app_name]    = "git-1.7.9.4-intel-universal-snow-leopard"
default[:git][:osx_dmg][:volumes_dir] = "Git 1.7.9.4 Snow Leopard Intel Universal"
default[:git][:osx_dmg][:package_id]  = "GitOSX.Installer.git1794.git.pkg"
default[:git][:osx_dmg][:url]         = "http://git-osx-installer.googlecode.com/files/git-1.7.9.4-intel-universal-snow-leopard.dmg"
default[:git][:osx_dmg][:checksum]    = "661c3fcf765572d3978df17c7636d59e"
