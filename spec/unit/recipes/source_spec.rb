require 'spec_helper'

# set some attributes

describe_recipe 'git::source' do
  context 'when using include_recipe or adding git::default to the run_list' do
    it 'installs git_client_source[default]' do
      expect(chef_run).to install_git_client_source('default')
    end
  end
end
