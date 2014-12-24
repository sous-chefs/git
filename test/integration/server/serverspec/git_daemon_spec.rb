require File.join(File.expand_path('..', ENV['BUSSER_ROOT']), 'kitchen/data/serverspec_helper')

describe port(9418) do
  it { should be_listening.with('tcp') }
end
