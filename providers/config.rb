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

def config_cmd
  cmd = 'git config'
  case new_resource.scope
  when 'system'
    cmd << ' --file /etc/gitconfig'
  when 'global'
    fail if new_resource.user.nil?
    cmd << " --file #{::File.join(::Dir.home(new_resource.user), '.gitconfig')}"
  end
  cmd << " #{new_resource.options}" if new_resource.options
  # There is a bug with git config who don't manage good user
  # Even if when set good user in execute resource
  # "git config --#{new_resource.scope}"
end

def config
  cmd = [config_cmd, new_resource.key].join(' ')
  git_config = Mixlib::ShellOut.new(cmd, :user => new_resource.user, :group => new_resource.user, :cwd => new_resource.path)
  git_config.run_command.stdout.chomp
end
