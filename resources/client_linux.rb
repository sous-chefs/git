unified_mode true

provides :git_client, os: 'linux'

# :install
property :package_name, String
property :package_version, String
property :package_action, Symbol, default: :install

# :install_from_source
property :source_checksum, String
property :source_prefix, String, default: '/usr/local'
property :source_url, String
property :source_use_pcre, [true, false], default: false
property :source_version, String

action_class do
  include GitCookbook::Helpers
end

action :install do
  # Software installation
  package "#{new_resource.name} :create #{parsed_package_name}" do
    package_name parsed_package_name
    version parsed_package_version
    action new_resource.package_action
  end
end

action :install_from_source do
  raise "source install is not supported on #{node['platform']}" unless platform_family?('rhel', 'suse', 'fedora', 'debian', 'amazon')

  build_essential 'install compilation tools for git'

  case node['platform_family']
  when 'rhel', 'fedora', 'amazon'
    pkgs = %w(tar expat-devel gettext-devel libcurl-devel openssl-devel perl-ExtUtils-MakeMaker zlib-devel)
    pkgs << 'pcre-devel' if new_resource.source_use_pcre
  when 'debian'
    pkgs = %w(libcurl4-gnutls-dev libexpat1-dev gettext libz-dev libssl-dev)
    pkgs << 'libpcre3-dev' if new_resource.source_use_pcre
  when 'suse'
    pkgs = %w(tar libcurl-devel libexpat-devel gettext-tools zlib-devel libopenssl-devel)
    pkgs << 'libpcre2-devel' if new_resource.source_use_pcre
  end

  package pkgs

  ark 'git' do
    url parsed_source_url
    extension 'tar.gz'
    version new_resource.source_version
    checksum parsed_source_checksum
    make_opts ["prefix=#{new_resource.source_prefix}", ('USE_LIBPCRE=1' if new_resource.source_use_pcre)]
    action :install_with_make
  end
end
