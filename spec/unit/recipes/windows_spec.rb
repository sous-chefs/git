require 'spec_helper'

describe_recipe 'git::windows' do
  let(:chef_run) do
    ChefSpec::ServerRunner.new(
      platform: 'windows',
      version: '2012R2'
    ).converge(described_recipe)
  end

  it { expect(chef_run).to install_git_client('default') }
end
