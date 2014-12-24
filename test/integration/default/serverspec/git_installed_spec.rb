require File.join(File.expand_path('..', ENV['BUSSER_ROOT']), 'kitchen/data/serverspec_helper')

describe 'git::default' do
  describe command('git --version') do
    its(:exit_status) { should eq 0 }
  end
end
