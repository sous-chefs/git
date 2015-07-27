require 'spec_helper'

describe_recipe 'git::windows' do
  let(:chef_run) { ChefSpec::SoloRunner.new(
    platform: 'windows', 
    version: '2012',
    step_into: 'git_client').converge(described_recipe) }
  
  it {expect(chef_run).to install_git_client('default') }
  it do
    expect(chef_run).to install_windows_package(chef_run.node['git']['display_name'])
      .with(source: chef_run.node['git']['url'])
      .with(checksum: chef_run.node['git']['checksum'])
      .with(installer_type: :inno)
  end

  it { expect(chef_run).to add_windows_path('C:\Program Files (x86)\Git\Cmd') }
  it do
    resource = chef_run.windows_path('C:\Program Files (x86)\Git\Cmd')
    expect(resource).to notify('ruby_block[Add Git Path]').to(:create).immediately
  end
  it do
    resource = chef_run.ruby_block('Add Git Path')
    expect(resource).to do_nothing    
  end
end
