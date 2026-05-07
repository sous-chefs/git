# frozen_string_literal: true

require_relative '../spec_helper'
require_relative '../../libraries/helpers'

describe GitCookbook::Helpers do
  subject(:helper) do
    Class.new do
      include GitCookbook::Helpers

      attr_accessor :node, :new_resource

      def platform?(platform)
        node['platform'] == platform
      end
    end.new
  end

  let(:resource) do
    Struct.new(
      :package_name,
      :package_version,
      :source_url,
      :source_checksum,
      :source_version,
      :source_prefix,
      :source_use_pcre,
      :windows_display_name,
      :windows_package_version,
      :windows_package_url,
      :windows_package_checksum,
      :windows_architecture
    ).new(nil, nil, nil, nil, '2.54.0', '/usr/local', false, nil, '2.54.0', nil, nil, '64')
  end

  before do
    helper.node = { 'platform' => 'ubuntu', 'platform_family' => 'debian', 'kernel' => { 'machine' => 'x86_64' } }
    helper.new_resource = resource
  end

  it 'defaults to the git package' do
    expect(helper.parsed_package_name).to eq('git')
  end

  it 'builds the default source URL from the version' do
    expect(helper.parsed_source_url).to eq('https://mirrors.edge.kernel.org/pub/software/scm/git/git-2.54.0.tar.gz')
  end

  it 'builds the Windows installer URL from properties' do
    expect(helper.parsed_windows_package_url).to eq('https://github.com/git-for-windows/git/releases/download/v2.54.0.windows.1/Git-2.54.0-64-bit.exe')
  end

  it 'detects an installed Windows Git executable' do
    allow(File).to receive(:exist?).and_call_original
    allow(File).to receive(:exist?).with('C:\\Program Files\\Git\\Cmd\\git.exe').and_return(true)

    expect(helper.windows_git_installed?).to be true
  end

  it 'does not detect Windows Git when the executable is absent' do
    allow(File).to receive(:exist?).and_call_original
    allow(File).to receive(:exist?).with('C:\\Program Files\\Git\\Cmd\\git.exe').and_return(false)

    expect(helper.windows_git_installed?).to be false
  end
end
