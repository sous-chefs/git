require 'spec_helper'

describe 'CentOS 6.4 client install' do
  let(:chef_run) do
    runner = ChefSpec::Runner.new(platform: 'centos', version: '6.4')
    runner.converge 'git::default'
  end

  it 'installs the correct packages' do
    expect(chef_run).to install_package('git')
  end

end
