require 'spec_helper'

describe 'freebsd 9.1 client install' do
  let(:chef_run) do
    runner = ChefSpec::Runner.new(platform: 'freebsd', version: '9.1')
    runner.converge 'git::default'
  end

  it 'installs the correct packages' do
    expect(chef_run).to install_package('git')
  end

end
