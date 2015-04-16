require 'chef/resource/lwrp_base'

class Chef
  class Resource
    class GitClient < Chef::Resource::LWRPBase
      self.resource_name = :git_client
      actions :install, :remove
      default_action :install

      provides :git_client

      # used by source providers
      attribute :version, kind_of: String, default: nil

      # used by package providers
      attribute :package_name, kind_of: String, default: nil
      attribute :package_version, kind_of: String, default: nil
      attribute :package_action, kind_of: Symbol, default: :install
    end
  end
end
