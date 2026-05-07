# frozen_string_literal: true

require_relative '../../spec_helper'

describe 'git_client' do
  step_into :git_client

  context 'on ubuntu' do
    platform 'ubuntu', '24.04'

    recipe do
      git_client 'default'
    end

    it { is_expected.to install_package('default :install git').with(package_name: 'git') }
  end

  context 'from source on ubuntu' do
    platform 'ubuntu', '24.04'

    recipe do
      git_client 'source' do
        source_version '2.54.0'
        action :install_from_source
      end
    end

    it { is_expected.to install_build_essential('install compilation tools for git') }
    it { is_expected.to install_package(%w(libcurl4-gnutls-dev libexpat1-dev gettext libz-dev libssl-dev)) }
    it { is_expected.to install_with_make_ark('git') }
  end

  context 'on macos' do
    platform 'mac_os_x', '12'

    recipe do
      git_client 'default'
    end

    it { is_expected.to install_package('default :install git').with(package_name: 'git', options: ['--override']) }
  end

  context 'on windows' do
    platform 'windows', '2022'

    recipe do
      git_client 'default' do
        windows_package_checksum 'abc123'
      end
    end

    it { is_expected.to install_windows_package('Git version 2.54.0') }
    it { is_expected.to add_windows_path('C:\\Program Files\\Git\\Cmd') }
  end

  context 'remove on ubuntu' do
    platform 'ubuntu', '24.04'

    recipe do
      git_client 'default' do
        action :remove
      end
    end

    it { is_expected.to remove_package('default :remove git').with(package_name: 'git') }
  end
end
