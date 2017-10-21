#
# Cookbook:: git
# Resource:: client_package
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

property :package_name, kind_of: String
property :package_version, kind_of: String
property :package_action, kind_of: Symbol, default: :install

action :install do
  include_recipe 'homebrew' if platform_family?('mac_os_x')
  package "#{new_resource.name} :create #{parsed_package_name}" do
    package_name parsed_package_name
    version parsed_package_version
    action new_resource.package_action
  end
end

action_class do
  include GitCookbook::Helpers
end
