# Migration

This release migrates the cookbook to a custom-resource-only API.

## Breaking Changes

* The cookbook-root `recipes/` directory has been removed.
* The cookbook-root `attributes/` directory has been removed.
* `git::default`, `git::package`, `git::source`, and `git::windows` are no longer public APIs.
* Node attributes under `node['git']` are no longer read by cookbook recipes.
* Git install behavior is configured with `git_client` properties.
* Git config behavior is configured with `git_config` properties.

## Recipe Replacements

### `git::default` or `git::package`

```ruby
git_client 'default'
```

### `git::source`

```ruby
git_client 'source' do
  source_version '2.54.0'
  source_prefix '/usr/local'
  source_checksum '45e8107643a44e3ce46f5665beb35af3932fb0d70017687905ab5d4e3aafa8eb'
  action :install_from_source
end
```

### `git::windows`

```ruby
git_client 'default' do
  windows_package_version '2.54.0'
  windows_architecture '64'
end
```

## Attribute Replacements

| Removed attribute | Replacement property |
|-------------------|----------------------|
| `node['git']['version']` for source | `git_client[source_version]` |
| `node['git']['prefix']` | `git_client[source_prefix]` |
| `node['git']['url']` for source | `git_client[source_url]` |
| `node['git']['checksum']` for source | `git_client[source_checksum]` |
| `node['git']['use_pcre']` | `git_client[source_use_pcre]` |
| `node['git']['version']` for Windows | `git_client[windows_package_version]` |
| `node['git']['architecture']` | `git_client[windows_architecture]` |
| `node['git']['url']` for Windows | `git_client[windows_package_url]` |
| `node['git']['checksum']` for Windows | `git_client[windows_package_checksum]` |
| `node['git']['display_name']` | `git_client[windows_display_name]` |

## Test Cookbook Examples

The migration examples are exercised in `test/cookbooks/test/recipes/default.rb` and
`test/cookbooks/test/recipes/source.rb`.
