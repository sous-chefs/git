require 'serverspec'

include Serverspec::Helper::Exec

describe port(9418) do
  it { should be_listening }
end
