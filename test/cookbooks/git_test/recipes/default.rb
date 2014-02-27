user 'random' do
  supports :manage_home => true
  home '/home/random'
end

git_config 'add name to root' do
  user 'random'
  scope 'global'
  key 'user.name'
  value 'John Doe'
end
