class Chef
  class Provider
    class GitClient
      class Package < Chef::Provider::GitClient
        provides :git_client

        action :install do
          if platform?('windows')
            chocolatey_package 'git' do
              action :install
              version parsed_package_version
            end
          else
            package "#{new_resource.name} :create #{parsed_package_name}" do
              package_name parsed_package_name
              version parsed_package_version
              action new_resource.package_action
              action :install
            end
          end
        end

        action :delete do
          if platform?('windows')
          else
            package "#{new_resource.name} :remove #{parsed_package_name}" do
              package_name parsed_package_name
              action :remove
            end
          end
        end
      end
    end
  end
end
