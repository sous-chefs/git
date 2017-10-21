#
# Cookbook:: git
# Resource:: client_windows
#
# Copyright:: 2017, Chef Software, Inc.
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
#

provides :git_client, os: 'windows'

property :windows_display_name, kind_of: String, default: nil
property :windows_package_url,  kind_of: String, default: nil
property :windows_package_checksum, kind_of: String, default: nil
property :windows_package_version, kind_of: String, default: nil

action :install do
  windows_package parsed_windows_display_name do
    action :install
    source parsed_windows_package_url
    checksum parsed_windows_package_checksum
    installer_type :inno
  end

  # Git is installed to Program Files (x86) on 64-bit machines and
  # 'Program Files' on 32-bit machines
  PROGRAM_FILES = if node['git']['architecture'] == '32'
                    ENV['ProgramFiles(x86)'] || ENV['ProgramFiles']
                  else
                    ENV['ProgramW6432'] || ENV['ProgramFiles']
                  end
  GIT_PATH = "#{PROGRAM_FILES}\\Git\\Cmd".freeze

  # COOK-3482 - windows_path resource doesn't change the current process
  # until the next chef-client run
  ruby_block 'Add Git Path' do
    block do
      ENV['PATH'] += ";#{GIT_PATH}"
    end
    not_if { ENV['PATH'] =~ /GIT_PATH/ }
    action :nothing
  end
  windows_path GIT_PATH do
    notifies :create, 'ruby_block[Add Git Path]', :immediately
    action :add
  end
end

action_class do
  include GitCookbook::Helpers
end
