class Chef
  class Provider
    class GitClient < Chef::Provider::LWRPBase
      include Chef::DSL::IncludeRecipe
      include GitCookbook::Helpers

      provides :git_service, os: 'linux'

      action :create do
        return "#{node['platform']} is not supported by the #{cookbook_name}::#{recipe_name} recipe" if platform?('windows')

        include_recipe 'git'

        directory new_resource.service_base_path do
          owner 'root'
          group 'root'
          mode '0755'
        end

        case node['platform_family']
        when 'debian'
          package 'xinetd'
        when 'rhel', 'amazon', 'fedora', 'suse'
          # TODO(ramereth): migrate to using systemd socket and unit on platforms which use it
          package %w(xinetd git-daemon)
        else
          log 'Platform requires setting up a git daemon service script.'
          log "Hint: /usr/bin/git daemon --export-all --user=nobody --group=daemon --base-path=#{new_resource.service_base_path}"
          return
        end

        template '/etc/xinetd.d/git' do
          backup false
          source 'git-xinetd.d.erb'
          owner 'root'
          group 'root'
          mode '0644'
          variables(
            git_daemon_binary: value_for_platform_family(
              'debian' => '/usr/lib/git-core/git-daemon',
              %w(rhel fedora amazon) => '/usr/libexec/git-core/git-daemon',
              'suse' => '/usr/lib/git/git-daemon'
            )
          )
          notifies :restart, 'service[xinetd]'
        end

        service 'xinetd' do
          action [:enable, :start]
        end
      end
    end
  end
end
