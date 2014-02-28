use_inline_resources

def whyrun_supported?
  true
end

action :set do
  if @current_resource.exists
    Chef::Log.info "#{ @new_resource } already exists - nothing to do."
  else
    execute "#{config_cmd} #{new_resource.key} \"#{new_resource.value}\"" do
      cwd new_resource.path
      user new_resource.user
      group new_resource.user
      Chef::Log.info "#{ @new_resource } created."
    end
  end
end

def initialize(*args)
  super

  @run_context.include_recipe 'git'
end

def load_current_resource
  @current_resource = Chef::Resource::GitConfig.new(@new_resource.name)
  @current_resource.exists = true if config == new_resource.value
end

# There is a problem with git config who don't manage good user
# Even if when set good user in execute resource
# "git config --#{new_resource.scope}"

def config_cmd
  cmd = "git config --file #{gitconfig_file}"
  cmd.concat(" #{new_resource.options}") if new_resource.options
  cmd
end

def gitconfig_file
  case new_resource.scope
  when 'system'
    return '/etc/gitconfig'
  when 'global'
    Chef::Log.error('Scope global need an user') unless new_resource.user
    return ::File.join(::Dir.home(new_resource.user), '.gitconfig')
  when 'local'
    Chef::Log.error('Scope local need a path') unless new_resource.path
    return ::File.join(new_resource.path, '.gitconfig')
  end
end

def config
  cmd = [config_cmd, new_resource.key].join(' ')
  git_config = Mixlib::ShellOut.new(cmd, :user => new_resource.user, :group => new_resource.user, :cwd => new_resource.path)
  Chef::Log.debug("Current config cmd: #{git_config.inspect}")
  git_config.run_command.stdout.chomp
end
