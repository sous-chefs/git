class Chef
  class Provider
    class GitClient
      class Source < Chef::Provider::GitClient
        include Chef::DSL::IncludeRecipe

        provides :git_client, os: 'linux' if respond_to?(:provides)

        action :install do
          return "#{node['platform']} is not supported by the #{cookbook_name}::#{recipe_name} recipe" if node['platform'] == 'windows'

          include_recipe 'build-essential'
          include_recipe 'yum-epel' if node['platform_family'] == 'rhel' && node['platform_version'].to_i < 6

          # move this to attributes.
          case node['platform_family']
          when 'fedora'
            pkgs = %w(openssl-devel libcurl-devel expat-devel perl-ExtUtils-MakeMaker)
          when 'rhel'
            case node['platform_version'].to_i
            when 5
              pkgs = %w(expat-devel gettext-devel curl-devel openssl-devel zlib-devel)
            when 6, 7
              pkgs = %w(expat-devel gettext-devel libcurl-devel openssl-devel perl-ExtUtils-MakeMaker zlib-devel)
            else
              pkgs = %w(expat-devel gettext-devel curl-devel openssl-devel perl-ExtUtils-MakeMaker zlib-devel) if node['platform'] == 'amazon'
            end
          when 'debian'
            pkgs = %w(libcurl4-gnutls-dev libexpat1-dev gettext libz-dev libssl-dev)
          end

          pkgs.each do |pkg|
            package pkg
          end

          # reduce line-noise-eyness
          remote_file "#{Chef::Config['file_cache_path']}/git-#{node['git']['version']}.tar.gz" do
            source node['git']['url']
            checksum node['git']['checksum']
            mode '0644'
            not_if "test -f #{Chef::Config['file_cache_path']}/git-#{node['git']['version']}.tar.gz"
          end

          # reduce line-noise-eyness
          execute "Extracting and Building Git #{node['git']['version']} from Source" do
            cwd Chef::Config['file_cache_path']
            command <<-COMMAND
    (mkdir git-#{node['git']['version']} && tar -zxf git-#{node['git']['version']}.tar.gz -C git-#{node['git']['version']} --strip-components 1)
    (cd git-#{node['git']['version']} && make prefix=#{node['git']['prefix']} install)
  COMMAND
            not_if "git --version | grep #{node['git']['version']}"
          end
        end

        action :delete do
        end
      end
    end
  end
end
