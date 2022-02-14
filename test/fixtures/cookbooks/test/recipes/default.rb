apt_update

git_client 'install it'

user_path = platform_family?('windows') ? 'C:\Users\random' : '/home/random'

user 'random' do
  manage_home true
  home user_path
end

git_config 'add name to random' do
  user 'random'
  scope 'global'
  key 'user.name'
  value 'John Doe global'
end

git "#{user_path}/git_repo" do
  repository 'https://github.com/chef-boneyard/chef-repo.git'
  user 'random'
end

git_config 'change local path' do
  user 'random'
  scope 'local'
  key 'user.name'
  value 'John Doe local'
  path "#{user_path}/git_repo"
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
