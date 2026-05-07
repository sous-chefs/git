# frozen_string_literal: true

apt_update 'update apt cache' if platform_family?('debian')

git_client 'source' do
  action :install_from_source
end
