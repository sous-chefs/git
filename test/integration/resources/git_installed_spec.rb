# rubocop:disable Chef/Deprecations/ResourceWithoutUnifiedTrue

describe command('git --version') do
  its('exit_status') { should eq 0 }
  its('stdout') { should match /git version/ }
end

describe ini('/home/random/.gitconfig') do
  its(%w(user name)) { should eq 'John Doe global' }
end

describe ini('/home/random/git_repo/.git/config') do
  its(%w(user name)) { should eq 'John Doe local' }
end

describe ini('/etc/gitconfig') do
  its(%w(user name)) { should eq 'John Doe system' }
  its(['url "https://github.com/"', 'insteadOf']) { should eq 'git://github.com/' }
end
