require_relative '../../spec_helper'

describe 'git::server' do
  platform 'ubuntu'

  step_into :git_service

  it do
    is_expected.to create_git_service('default').with(
      service_base_path: '/srv/git'
    )
  end

  it do
    expect(chef_run).to create_directory('/srv/git').with(
      owner: 'root',
      group: 'root',
      mode: '0755'
    )
  end

  it do
    expect(chef_run).to create_template('/etc/xinetd.d/git').with(
      backup: false,
      source: 'git-xinetd.d.erb',
      owner: 'root',
      group: 'root',
      mode: '0644'
    )
  end

  it { expect(chef_run).to enable_service('xinetd') }
  it { expect(chef_run).to start_service('xinetd') }
end
