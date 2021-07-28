unified_mode true

provides :git_client, os: 'windows'

property :windows_display_name, String
property :windows_package_url, String
property :windows_package_checksum, String
property :windows_package_version, String

action_class do
  include GitCookbook::Helpers
end

action :install do
  windows_package parsed_windows_display_name do
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
  # environment variables. Therefore, git won't actually be on the PATH
  # until the next chef-client run
  ruby_block 'Add Git Path' do
    block do
      ENV['PATH'] += ";#{GIT_PATH}"
    end
    not_if { ENV['PATH'] =~ /GIT_PATH/ }
    action :nothing
  end

  windows_path GIT_PATH do
    notifies :run, 'ruby_block[Add Git Path]', :immediately
  end
end
