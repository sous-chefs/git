describe command('git --version') do
  its(:exit_status) { should eq 0 }
end
