apt_update

git_client 'install it'

home_dir =
  if windows?
    'C:\temp'
  elsif macos?
    '/Users/random'
  else
    '/home/random'
  end

user 'random' do
  manage_home true
  home home_dir
end unless windows?

directory 'C:\temp' if windows?

git_config 'add name to random' do
  user 'random' unless windows?
  scope 'global'
  key 'user.name'
  value 'John Doe global'
end

git "#{home_dir}/git_repo" do
  repository 'https://github.com/chef/chef-repo.git'
  user 'random' unless windows?
end

git_config 'change local path' do
  user 'random' unless windows?
  scope 'local'
  key 'user.name'
  value 'John Doe local'
  path "#{home_dir}/git_repo"
end

git_config 'change system config' do
  scope 'system'
  key 'user.name'
  value 'John Doe system'
end

git_config 'url.https://github.com/.insteadOf' do
  value 'git://github.com/'
  scope 'system'
  options '--add'
end
