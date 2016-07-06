describe port(9418) do
  it { should be_listening }
  its('protocols') { should eq ['tcp'] }
end
