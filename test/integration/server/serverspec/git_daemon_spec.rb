require 'serverspec'

set :backend, :exec

describe 'git::default' do
  describe port(9418) do
    it { should be_listening.with('tcp') }
  end
end
