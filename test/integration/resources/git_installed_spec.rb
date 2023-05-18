# rubocop:disable Chef/Deprecations/ResourceWithoutUnifiedTrue
home_dir =
  if os.family == 'windows'
    if user('vagrant')
      'C:/Users/vagrant'
    else
      'C:/Users/RUNNER~1'
    end
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

describe command('git --version') do
  its('exit_status') { should eq 0 }
  its('stdout') { should match /git version/ }
end

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
