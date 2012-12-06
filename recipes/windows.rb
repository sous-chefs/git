#
# Cookbook Name:: git
# Recipe:: windows
#
# Copyright 2008-2009, Opscode, Inc.
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


# Create 'Path Option' reg value so that 
# 'Run Git from the Windows Command Prompt' option is selected during install
if node['kernel']['machine'] =~ /x86_64/
  SETUP_OPTIONS_KEY = 'HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Git_is1'
else
  SETUP_OPTIONS_KEY =  'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Git_is1'
end

windows_registry SETUP_OPTIONS_KEY do
  values 'Inno Setup CodeFile: Path Option'  => node['git']['setup_path_option']
end

windows_registry SETUP_OPTIONS_KEY do
  values 'Inno Setup CodeFile: CRLF Option' => node['git']['setup_crlf_option']
end

windows_package node['git']['display_name'] do
  source node['git']['url']
  checksum node['git']['checksum']
  installer_type :inno
end
