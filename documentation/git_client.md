# git_client

The `git_client` resource manages the installation of a Git client on a machine.

`Note`: on macOS systems homebrew must first be installed on the system before running this resource. Prior to version 9.0 of this cookbook homebrew was automatically installed.

## Example

```ruby
git_client 'default'
```

## Example of source install

```ruby
git_client 'source' do
  source_version '2.14.2'
  source_checksum 'a03a12331d4f9b0f71733db9f47e1232d4ddce00e7f2a6e20f6ec9a19ce5ff61'
  action :install_from_source
end
```
