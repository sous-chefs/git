# frozen_string_literal: true

control 'git-source-01' do
  impact 1.0
  title 'Git is installed from source'

  describe command('/usr/local/bin/git --version') do
    its('exit_status') { should eq 0 }
    its('stdout') { should match /git version/ }
  end
end
