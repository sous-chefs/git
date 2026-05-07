# frozen_string_literal: true

require_relative '../../spec_helper'

describe 'git_config' do
  step_into :git_config
  platform 'ubuntu', '24.04'

  before do
    shellout = instance_double(Mixlib::ShellOut, stdout: '')
    allow(shellout).to receive(:run_command)
    allow(Mixlib::ShellOut).to receive(:new).and_return(shellout)
    stub_command('git config --system --get user.name').and_return(true)
  end

  context 'set a global value' do
    recipe do
      git_config 'user.name' do
        value 'Jane Doe'
      end
    end

    it { is_expected.to run_execute('git config --global user.name "Jane Doe"') }
  end

  context 'unset a system value' do
    recipe do
      git_config 'user.name' do
        scope 'system'
        action :unset
      end
    end

    it { is_expected.to run_execute('git config --system --unset-all user.name') }
  end

  context 'set a file-scoped value with a home-relative config path' do
    before do
      allow(::Dir).to receive(:home).and_call_original
      allow(::Dir).to receive(:home).with(no_args).and_return('/root')
    end

    recipe do
      git_config 'user.signingkey' do
        value 'FA2D8E280A6DD5'
        scope 'file'
        config_file '~/.gitconfig.key'
      end
    end

    it { is_expected.to run_execute('git config --file "/root/.gitconfig.key" user.signingkey "FA2D8E280A6DD5"') }
  end
end
