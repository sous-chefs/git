require 'spec_helper'

# set some attributes

describe_recipe 'git::source' do
  context 'when using include_recipe or adding git::default to the run_list' do
    it 'installs git_client[default]' do
      expect(chef_run).to install_from_source_git_client('default')
    end
  end
end
