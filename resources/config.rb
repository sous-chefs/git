# frozen_string_literal: true

provides :git_config
unified_mode true

property :key, String, name_property: true
property :value, String
property :scope, String, equal_to: %w(local global system file), default: 'global', desired_state: false
property :config_file, String,
         desired_state: false,
         coerce: proc { |v| v.start_with?('~/', '~\\') ? ::File.join(::Dir.home, v[2, v.length]) : v }
property :path, String, desired_state: false
property :user, String, desired_state: false
property :group, String, desired_state: false
property :password, String, desired_state: false, sensitive: true
property :options, String, desired_state: false

default_action :set

load_current_value do
  begin
    home_dir = ::Dir.home(user)
  rescue ArgumentError
    value nil
  end

  cmd_env = user ? { 'USER' => user, 'HOME' => home_dir } : nil
  config_vals = Mixlib::ShellOut.new(
    "git config --get --#{scope} #{config_file} #{key}",
    user: user,
    group: group,
    password: password,
    cwd: path,
    env: cmd_env
  )
  config_vals.run_command
  if config_vals.stdout.empty?
    value nil
  else
    value config_vals.stdout.chomp
  end
end

action :set do
  raise 'git_config value is required for action :set' if new_resource.value.nil?

  converge_if_changed do
    execute "#{config_cmd} #{new_resource.key} \"#{new_resource.value}\" #{new_resource.options}".rstrip do
      cwd new_resource.path
      user new_resource.user
      group new_resource.group
      password new_resource.password
      environment cmd_env
    end
  end
end

action :unset do
  execute "#{config_cmd} --unset-all #{new_resource.key}" do
    cwd new_resource.path
    user new_resource.user
    group new_resource.group
    password new_resource.password
    environment cmd_env
    only_if "#{config_cmd} --get #{new_resource.key}"
  end
end

action_class do
  def config_cmd
    return ['git config', "--#{new_resource.scope}"].join(' ') unless new_resource.scope == 'file'

    %(git config --file "#{new_resource.config_file}")
  end

  def cmd_env
    new_resource.user ? { 'USER' => new_resource.user, 'HOME' => ::Dir.home(new_resource.user) } : nil
  end
end
