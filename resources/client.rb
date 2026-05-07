# frozen_string_literal: true

provides :git_client
unified_mode true

property :package_name, String
property :package_version, String
property :package_action, Symbol, default: :install

property :source_checksum, String
property :source_prefix, String, default: '/usr/local'
property :source_url, String
property :source_use_pcre, [true, false], default: false
property :source_version, String, default: '2.54.0'

property :windows_architecture, String, equal_to: %w(32 64 arm64), default: lazy { node['kernel']['machine'] == 'x86_64' ? '64' : '32' }
property :windows_display_name, String
property :windows_package_url, String
property :windows_package_checksum, String
property :windows_package_version, String, default: '2.54.0'

default_action :install

action_class do
  include GitCookbook::Helpers
end

action :install do
  if platform_family?('windows')
    windows_package parsed_windows_display_name do
      source parsed_windows_package_url
      checksum parsed_windows_package_checksum if parsed_windows_package_checksum
      version new_resource.windows_package_version
      installer_type :inno
      not_if { windows_git_installed? }
    end

    ruby_block 'Add Git Path' do
      block do
        ENV['PATH'] += ";#{windows_git_path}"
      end
      not_if { ENV['PATH'].split(';').include?(windows_git_path) }
      action :nothing
    end

    windows_path windows_git_path do
      notifies :run, 'ruby_block[Add Git Path]', :immediately
      not_if { windows_path_configured? }
    end
  else
    package "#{new_resource.name} :install #{parsed_package_name}" do
      package_name parsed_package_name
      version new_resource.package_version
      options '--override' if platform?('mac_os_x')
      action new_resource.package_action
    end
  end
end

action :install_from_source do
  raise "source install is not supported on #{node['platform']}" unless platform_family?('rhel', 'suse', 'fedora', 'debian', 'amazon')

  build_essential 'install compilation tools for git'

  package source_build_packages

  ark 'git' do
    url parsed_source_url
    extension 'tar.gz'
    version new_resource.source_version
    checksum parsed_source_checksum
    make_opts source_make_opts
    action :install_with_make
  end
end

action :remove do
  if platform_family?('windows')
    windows_package parsed_windows_display_name do
      action :remove
    end

    windows_path windows_git_path do
      action :remove
    end
  else
    package "#{new_resource.name} :remove #{parsed_package_name}" do
      package_name parsed_package_name
      action :remove
    end
  end
end
