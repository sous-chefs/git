unified_mode true

provides :git_client, platform: 'mac_os_x'

action :install do
  package 'git' do
    options '--override'
  end
end
