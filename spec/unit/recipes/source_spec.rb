require_relative '../../spec_helper'

describe 'git::source' do
  platform 'ubuntu'

  step_into :git_client

  before do
    stub_command(%r{test -f /tmp/.+/git-2.17.1.tar.gz})
    stub_command('git --version | grep 2.17.1')
    stub_command('/usr/local/bin/git --version | grep 2.17.1')
  end

  it do
    is_expected.to install_from_source_git_client('default').with(
      source_checksum: '690f12cc5691e5adaf2dd390eae6f5acce68ae0d9bd9403814f8a1433833f02a',
      source_prefix: '/usr/local',
      source_url: 'https://nodeload.github.com/git/git/tar.gz/v2.17.1',
      source_use_pcre: false,
      source_version: '2.17.1'
    )
  end
end
