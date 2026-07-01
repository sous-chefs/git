# frozen_string_literal: true

apt_update 'update apt cache' if platform_family?('debian')

package 'ca-certificates'

git_client 'source' do
  source_url 'http://mirrors.edge.kernel.org/pub/software/scm/git/git-2.54.0.tar.gz'
  action :install_from_source
end
