# git_config

The `git_config` resource manages the configuration of Git client on a machine.

## Example

```ruby
git_config 'url.https://github.com/.insteadOf' do
  value 'git://github.com/'
  scope 'system'
  options '--add'
end
```

## Properties

Currently, there are distinct sets of resource properties, used by the providers for source, package, macos, and windows.

### used by Linux provider

- `package_name` - Package name to install on Linux machines. Defaults to a calculated value based on platform.
- `package_version` - Defaults to nil.
- `package_action` - Defaults to `:install`

### used by Linux source install

- `source_prefix` - Defaults to '/usr/local'
- `source_url` - Defaults to a calculated URL based on source_version
- `source_version` - Defaults to 2.8.1
- `source_use_pcre` - configure option for build. Defaults to false
- `source_checksum` - Defaults to a known value for the 2.8.1 source tarball

### used by the Windows provider

- `windows_display_name` - Windows display name
- `windows_package_url` - Defaults to the Internet
- `windows_package_checksum` - Defaults to the value for 2.8.1
