require 'serverspec'

set :backend, :exec

puts "os: #{os}"

describe 'git::default' do
  describe command('git --version') do
    its(:exit_status) { should eq 0 }
    # its(:stdout) { should match(/something/) }
  end
end
