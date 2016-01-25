require 'spec_helper'

describe_recipe 'git::windows' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new(
      platform: 'windows',
      version: '2012',
      ).converge(described_recipe)
  end

  it { expect(chef_run).to install_git_client('default') }
  it do
    expect(chef_run).to install_windows_package(chef_run.node['git']['display_name'])
      .with(source: chef_run.node['git']['url'])
      .with(checksum: chef_run.node['git']['checksum'])
      .with(installer_type: :inno)
  end
end
