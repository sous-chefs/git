if defined?(ChefSpec)

  def install_git_client(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:git_client, :install, resource_name)
  end

end
