# frozen_string_literal: true

home_dir =
  if os.family == 'windows'
    'C:/temp'
  elsif os.family == 'darwin'
    '/Users/random'
  else
    '/home/random'
  end

repo_dir =
  if os.family == 'windows'
    'C:/temp'
  else
    home_dir
  end

etc_dir =
  if os.family == 'windows'
    'C:/Program Files/Git/etc'
  elsif os.family == 'darwin'
    '/usr/local/etc'
  else
    '/etc'
  end

control 'git-client-01' do
  impact 1.0
  title 'Git is installed'

  describe command('git --version') do
    its('exit_status') { should eq 0 }
    its('stdout') { should match /git version/ }
  end
end

control 'git-config-01' do
  impact 1.0
  title 'Git configuration is managed'

  describe ini("#{home_dir}/.gitconfig") do
    its(%w(user name)) { should eq 'John Doe global' }
  end

  describe ini("#{repo_dir}/git_repo/.git/config") do
    its(%w(user name)) { should eq 'John Doe local' }
  end

  describe ini("#{etc_dir}/gitconfig") do
    its(%w(user name)) { should eq 'John Doe system' }
    its(['url "https://github.com/"', 'insteadOf']) { should eq 'git://github.com/' }
  end

  describe ini('/root/.gitconfig.key') do
    its(%w(user signingkey)) { should eq 'FA2D8E280A6DD5' }
  end
end
