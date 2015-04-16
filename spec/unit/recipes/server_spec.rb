# require 'spec_helper'

# describe_recipe 'git::server' do
#   it { expect(chef_run).to include_recipe('git::default') }
#   it do
#     expect(chef_run).to create_directory(chef_run.node['git']['server']['base_path'])
#       .with(owner: 'root')
#       .with(group: 'root')
#       .with(mode: '0755')
#   end
#   it do
#     expect(chef_run).to create_template('/etc/xinetd.d/git')
#       .with(backup: false)
#       .with(source: 'git-xinetd.d.erb')
#       .with(owner: 'root')
#       .with(group: 'root')
#       .with(mode: '0644')
#   end
#   it { expect(chef_run).to enable_service('xinetd') }
#   it { expect(chef_run).to restart_service('xinetd') }
# end
