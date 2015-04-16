class Chef
  class Provider
    class GitClient
      class Osx < Chef::Provider::GitClient
        include Chef::DSL::IncludeRecipe

        provides :git_client, os: 'mac_os_x' if respond_to?(:provides)

        action :install do
          dmg_package 'GitOSX-Installer' do
            app node['git']['osx_dmg']['app_name']
            package_id node['git']['osx_dmg']['package_id']
            volumes_dir node['git']['osx_dmg']['volumes_dir']
            source node['git']['osx_dmg']['url']
            checksum node['git']['osx_dmg']['checksum']
            type 'pkg'
            action :install
          end
        end

        action :delete do
        end
      end
    end
  end
end
