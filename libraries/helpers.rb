module GitCookbook
  module Helpers
    # linux packages default to distro offering
    def parsed_package_name
      return new_resource.package_name if new_resource.package_name
      return 'developer/versioning/git' if platform?('omnios')
      return 'scmgit' if platform?('smartos')
      'git'
    end

    def parsed_package_version
      new_resource.package_version if new_resource.package_version
    end

    # source
    def parsed_source_url
      return new_resource.source_url if new_resource.source_url
      "https://nodeload.github.com/git/git/tar.gz/v#{new_resource.source_version}"
    end

    def parsed_source_checksum
      return new_resource.source_checksum if new_resource.source_checksum
      '690f12cc5691e5adaf2dd390eae6f5acce68ae0d9bd9403814f8a1433833f02a' # 2.17.1 tarball
    end

    # windows
    def parsed_windows_display_name
      return new_resource.windows_display_name if new_resource.windows_display_name
      "Git version #{parsed_windows_package_version}"
    end

    def parsed_windows_package_version
      return new_resource.windows_package_version if new_resource.windows_package_version
      '2.39.2'
    end

    def parsed_windows_package_url
      return new_resource.windows_package_url if new_resource.windows_package_url
      if node['kernel']['machine'] == 'x86_64'
        "https://github.com/git-for-windows/git/releases/download/v#{parsed_windows_package_version}.windows.1/Git-#{parsed_windows_package_version}-64-bit.exe"
      else
        "https://github.com/git-for-windows/git/releases/download/v#{parsed_windows_package_version}.windows.1/Git-#{parsed_windows_package_version}-32-bit.exe"
      end
    end

    def parsed_windows_package_checksum
      return new_resource.windows_package_checksum if new_resource.windows_package_checksum
      if node['kernel']['machine'] == 'x86_64'
        'D7608FBD854B3689102FF48B03C8CC77B35138F9F7350D134306DA0BA5751464'
      else
        'ADDF55B0A57F38A7950B3AD37CE5C76752202E6818D9F8995B477496B71FB757'
      end
    end
  end
end
