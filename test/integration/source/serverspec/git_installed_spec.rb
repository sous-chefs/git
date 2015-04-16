require 'serverspec'

set :backend, :exec

describe 'git::default' do
  describe command('/usr/local/bin/git --version') do
    its(:exit_status) { should eq 0 }
    # its(:stdout) { should match(/something/) }
  end
end
