require 'chef/resource/lwrp_base'

class Chef
  class Resource
    class GitService < Chef::Resource::LWRPBase
      self.resource_name = :git_service
      actions :create
      default_action :create

      provides :git_service
    end
  end
end
