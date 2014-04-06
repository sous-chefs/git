require 'spec_helper'

describe 'CentOS 5.9 client install' do
  let(:chef_run) do
    runner = ChefSpec::Runner.new(platform: 'centos', version: '5.9')
    runner.converge 'git::default'
  end

  it 'include yum-epel recipe' do
    expect(chef_run).to include_recipe('yum-epel')
  end

  it 'installs the correct packages' do
    expect(chef_run).to install_package('git')
  end

end
