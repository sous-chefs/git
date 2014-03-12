user 'random' do
  supports :manage_home => true
  home '/home/random'
end

git_config 'add name to random' do
  user 'random'
  scope 'global'
  key 'user.name'
  value 'John Doe global'
end

git '/home/random/git_repo' do
  repository 'https://github.com/opscode/chef-repo.git'
  user 'random'
end

git_config 'change local path' do
  user 'random'
  scope 'local'
  key 'user.name'
  value 'John Doe local'
  path '/home/random/git_repo'
end

git_config 'change system config' do
  scope 'system'
  key 'user.name'
  value 'John Doe system'
end
