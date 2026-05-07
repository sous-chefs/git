# frozen_string_literal: true

apt_update 'update apt cache' if platform_family?('debian')

git_client 'default'

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

repo_path = "#{home_dir}/git_repo"

directory repo_path do
  owner 'random' unless windows?
end

execute 'initialize local git repository' do
  command 'git init'
  cwd repo_path
  user 'random' unless windows?
  creates "#{repo_path}/.git"
end

git_config 'add name to random' do
  user 'random' unless windows?
  scope 'global'
  key 'user.name'
  value 'John Doe global'
end

git_config 'change local path' do
  user 'random' unless windows?
  scope 'local'
  key 'user.name'
  value 'John Doe local'
  path repo_path
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

git_config 'user.signingkey' do
  value 'FA2D8E280A6DD5'
  scope 'file'
  config_file '~/.gitconfig.key'
end
