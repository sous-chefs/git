module GitCookbook
  module Helpers
    def parsed_package_name
      return new_resource.package_name if new_resource.package_name
      return 'git-core' if node['platform'] == 'ubuntu' && node['platform_version'].to_f < 10.10
      return 'developer/versioning/git' if node['platform'] == 'omnios'
      return 'scmgit' if node['platform'] == 'smartos'
      'git'
    end

    def parsed_source_url
      return new_resource.source_url if new_resource.source_url
      return "https://nodeload.github.com/git/git/tar.gz/v#{new_resource.source_version}"
    end

    def parsed_source_checksum
      return new_resource.source_checksum if new_resource.source_checksum
      return '0f30984828d573da01d9f8e78210d5f4c56da1697fd6d278bad4cfa4c22ba271' # 1.9.5 tarball
    end

    def parsed_package_version
      return new_resource.package_version if new_resource.package_version
    end

    def parsed_version
      return new_resource.version if new_resource.version
    end
  end
end
