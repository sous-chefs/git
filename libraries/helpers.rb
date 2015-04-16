module GitCookbook
  module Helpers
    def parsed_package_name
      return new_resource.package_name if new_resource.package_name
      return 'git-core' if node['platform'] == 'ubuntu' && node['platform_version'].to_f < 10.10
      return 'developer/versioning/git' if node['platform'] == 'omnios'
      return 'scmgit' if node['platform'] == 'smartos'
      'git'
    end

    def parsed_package_version
      return new_resource.package_version if new_resource.package_version
    end

    def parsed_version
      return new_resource.version if new_resource.version
    end
  end
end
