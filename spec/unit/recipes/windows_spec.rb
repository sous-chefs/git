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
      windows_display_name: 'Git version 2.35.1',
      windows_package_url: 'https://github.com/git-for-windows/git/releases/download/v2.35.1.windows.1/Git-2.35.1-64-bit.exe',
      windows_package_checksum: '5d66948e7ada0ab184b2745fdf6e11843443a97655891c3c6268b5985b88bf4f'
    )
  end
end
