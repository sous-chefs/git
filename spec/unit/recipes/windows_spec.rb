require_relative '../../spec_helper'

describe_recipe 'git::windows' do
  let(:chef_run) do
    ChefSpec::ServerRunner.new(
      platform: 'windows',
      version: '10'
    ).converge(described_recipe)
  end

  it do
    expect(chef_run).to install_git_client('default').with(
      windows_display_name: 'Git version 2.8.1',
      windows_package_url: 'https://github.com/git-for-windows/git/releases/download/v2.8.1.windows.1/Git-2.8.1-64-bit.exe',
      windows_package_checksum: '5e5283990cc91d1e9bd0858f8411e7d0afb70ce26e23680252fb4869288c7cfb'
    )
  end
end
