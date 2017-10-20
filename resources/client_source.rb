#
# Cookbook:: git
# Resource:: client_source
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

property :source_checksum, kind_of: String
property :source_prefix, kind_of: String, default: '/usr/local'
property :source_url, kind_of: String
property :source_use_pcre, kind_of: [TrueClass, FalseClass], default: false
property :source_version, kind_of: String

# used by linux package providers
property :package_name, kind_of: String
property :package_version, kind_of: String
property :package_action, kind_of: Symbol, default: :install

action :install do
  raise "#{node['platform']} is not supported by the git_client source resource" unless platform_family?('rhel', 'suse', 'fedora', 'debian', 'amazon')

  include_recipe 'build-essential'

  case node['platform_family']
  when 'rhel', 'fedora', 'amazon'
    pkgs = %w(tar expat-devel gettext-devel libcurl-devel openssl-devel perl-ExtUtils-MakeMaker zlib-devel)
    pkgs += %w( pcre-devel ) if new_resource.source_use_pcre
  when 'debian'
    pkgs = %w(libcurl4-gnutls-dev libexpat1-dev gettext libz-dev libssl-dev)
    pkgs += %w( libpcre3-dev ) if new_resource.source_use_pcre
  when 'suse'
    pkgs = %w(tar libcurl-devel libexpat-devel gettext-tools zlib-devel libopenssl-devel)
    pkgs += %w( libpcre2-devel ) if new_resource.source_use_pcre
  end

  package pkgs
  remote_file "#{Chef::Config['file_cache_path']}/git-#{new_resource.source_version}.tar.gz" do
    source parsed_source_url # helpers.rb
    checksum parsed_source_checksum # helpers.rb
    mode '0644'
    not_if "test -f #{Chef::Config['file_cache_path']}/git-#{new_resource.source_version}.tar.gz"
  end

  execute "Extracting and Building Git #{new_resource.source_version} from source" do
    cwd Chef::Config['file_cache_path']
    additional_make_params = ''
    additional_make_params += 'USE_LIBPCRE=1' if new_resource.source_use_pcre
    command <<-COMMAND
    (mkdir git-#{new_resource.source_version} && tar -zxf git-#{new_resource.source_version}.tar.gz -C git-#{new_resource.source_version} --strip-components 1)
    (cd git-#{new_resource.source_version} && make prefix=#{new_resource.source_prefix} #{additional_make_params} install)
    COMMAND
    not_if "git --version | grep #{new_resource.source_version}"
    not_if "#{new_resource.source_prefix}/bin/git --version | grep #{new_resource.source_version}"
  end
end

action_class do
  include GitCookbook::Helpers
end
