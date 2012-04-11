case platform
when 'windows'
  set[:git][:version] = "1.7.9-preview20120201"
  set[:git][:url] = "http://msysgit.googlecode.com/files/Git-#{node[:git][:version]}.exe"
  set[:git][:checksum] = "0627394709375140d1e54e923983d259a60f9d8e"
end
