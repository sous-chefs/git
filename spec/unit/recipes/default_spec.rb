require_relative '../../spec_helper'

describe 'git::default' do
  context 'on windows' do
    let(:chef_run) do
      ChefSpec::ServerRunner.new(
        platform: 'windows',
        version: '10'
      ).converge(described_recipe)
    end

    it { expect(chef_run).to include_recipe('git::windows') }
  end

  context 'on linux' do
    platform 'ubuntu'

    it { is_expected.to install_git_client('default') }
  end
end
