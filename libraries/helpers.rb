# frozen_string_literal: true

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
      new_resource.package_version
    end

    # source
    def parsed_source_url
      return new_resource.source_url if new_resource.source_url
      "https://mirrors.edge.kernel.org/pub/software/scm/git/git-#{new_resource.source_version}.tar.gz"
    end

    def parsed_source_checksum
      return new_resource.source_checksum if new_resource.source_checksum
      '45e8107643a44e3ce46f5665beb35af3932fb0d70017687905ab5d4e3aafa8eb' # 2.54.0 tarball
    end

    def source_build_packages
      packages =
        case node['platform_family']
        when 'rhel', 'fedora', 'amazon'
          %w(tar expat-devel gettext-devel libcurl-devel openssl-devel perl-ExtUtils-MakeMaker zlib-devel)
        when 'debian'
          %w(libcurl4-gnutls-dev libexpat1-dev gettext libz-dev libssl-dev)
        when 'suse'
          %w(tar libcurl-devel libexpat-devel gettext-tools zlib-devel libopenssl-devel)
        end

      return packages unless new_resource.source_use_pcre

      packages + [source_pcre_package]
    end

    def source_pcre_package
      case node['platform_family']
      when 'rhel', 'fedora', 'amazon'
        'pcre-devel'
      when 'debian'
        'libpcre3-dev'
      when 'suse'
        'libpcre2-devel'
      end
    end

    def source_make_opts
      ["prefix=#{new_resource.source_prefix}", ('USE_LIBPCRE=1' if new_resource.source_use_pcre)].compact
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
      if new_resource.windows_architecture == '64'
        "https://github.com/git-for-windows/git/releases/download/v#{parsed_windows_package_version}.windows.1/Git-#{parsed_windows_package_version}-64-bit.exe"
      elsif new_resource.windows_architecture == 'arm64'
        "https://github.com/git-for-windows/git/releases/download/v#{parsed_windows_package_version}.windows.1/Git-#{parsed_windows_package_version}-arm64.exe"
      else
        "https://github.com/git-for-windows/git/releases/download/v#{parsed_windows_package_version}.windows.1/Git-#{parsed_windows_package_version}-32-bit.exe"
      end
    end

    def parsed_windows_package_checksum
      return new_resource.windows_package_checksum if new_resource.windows_package_checksum
      nil
    end

    def windows_git_path
      "#{windows_program_files}\\Git\\Cmd"
    end

    def windows_git_exe
      "#{windows_git_path}\\git.exe"
    end

    def windows_git_installed?
      ::File.exist?(windows_git_exe)
    end

    def windows_path_configured?
      windows_path_entries.include?(windows_git_path.downcase)
    end

    def windows_path_entries
      ENV['PATH'].to_s.split(';').map { |path| path.tr('/', '\\').downcase }
    end

    def windows_program_files
      if new_resource.windows_architecture == '32'
        ENV['ProgramFiles(x86)'] || ENV['ProgramFiles'] || 'C:\\Program Files (x86)'
      else
        ENV['ProgramW6432'] || ENV['ProgramFiles'] || 'C:\\Program Files'
      end
    end
  end
end
