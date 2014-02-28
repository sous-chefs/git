require 'serverspec'

include Serverspec::Helper::Exec

describe command('git --version') do
  it { should return_exit_status 0 }
end
