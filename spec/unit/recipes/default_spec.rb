require 'spec_helper'

describe_recipe 'git::default' do
  context %(with node['platform'] = 'ubuntu' AND node['platform_version'] = '14.04') do
    let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '14.04').converge(described_recipe) }
    it { expect(chef_run).to install_package('git') }
  end

  context %(with node['platform'] = 'ubuntu' AND node['platform_version'] = '12.04') do
    let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '12.04').converge(described_recipe) }
    it { expect(chef_run).to install_package('git') }
  end

  context %(with node['platform'] = 'ubuntu' AND node['platform_version'] = '10.04') do
    let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '10.04').converge(described_recipe) }
    it { expect(chef_run).to install_package('git-core') }
  end

  %w(redhat centos).each do |family|
    context %(with node['platform'] = '#{family}' AND node['platform_version'] = '5.10') do
      let(:chef_run) { ChefSpec::SoloRunner.new(platform: family, version: '5.10').converge(described_recipe) }
      it { expect(chef_run).to include_recipe('yum-epel') }
      it { expect(chef_run).to install_package('git') }
    end

    context %(with node['platform'] = '#{family}' AND node['platform_version'] = '6.4') do
      let(:chef_run) { ChefSpec::SoloRunner.new(platform: family, version: '6.4').converge(described_recipe) }
      it { expect(chef_run).to install_package('git') }
    end

    context %(with node['platform'] = '#{family}' AND node['platform_version'] = '7.0') do
      let(:chef_run) { ChefSpec::SoloRunner.new(platform: family, version: '7.0').converge(described_recipe) }
      it { expect(chef_run).to install_package('git') }
    end
  end

  context %(with node['platform'] = 'fedora' AND node['platform_version'] = '19') do
    let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'fedora', version: '19').converge(described_recipe) }
    it { expect(chef_run).to install_package('git') }
  end

  context %(with node['platform'] = 'fedora' AND node['platform_version'] = '20') do
    let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'fedora', version: '20').converge(described_recipe) }
    it { expect(chef_run).to install_package('git') }
  end

  context %(with node['platform'] = 'freebsd' AND node['platform_version'] = '9.1') do
    let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'freebsd', version: '9.1').converge(described_recipe) }
    it { expect(chef_run).to install_package('git') }
  end

  context %(with node['platform'] = 'mac_os_x' AND node['platform_version'] = '10.6.8') do
    let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'mac_os_x', version: '10.6.8').converge(described_recipe) }
    it { expect(chef_run).to install_dmg_package('GitOSX-Installer') }
  end

  context %(with node['platform'] = 'windows' AND node['platform_version'] = '2012') do
    let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'windows', version: '2012').converge(described_recipe) }
    it { expect(chef_run).to include_recipe('git::windows') }
  end

  context %(with node['platform'] = 'omnios' AND node['platform_version'] = '151002') do
    let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'omnios', version: '151002').converge(described_recipe) }
    it do
      expect(chef_run).to install_package('git')
        .with(package_name: 'developer/versioning/git')
    end
  end

  context %(with node['platform'] = 'smartos' AND node['platform_version'] = '5.11') do
    let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'smartos', version: '5.11').converge(described_recipe) }
    it do
      expect(chef_run).to install_package('git')
        .with(package_name: 'scmgit')
    end
  end
end
