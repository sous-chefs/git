# git_client

The `git_client` resource manages the installation of a Git client on a machine.

`Note`: on macOS systems homebrew must first be installed on the system before running this resource. Prior to version 9.0 of this cookbook homebrew was automatically installed.

## Actions

| Action | Description |
|--------|-------------|
| `:install` | Installs Git from the platform package provider or Git for Windows installer. Default. |
| `:install_from_source` | Builds and installs Git from source on supported Linux platforms. |
| `:remove` | Removes the package or Windows package and Windows PATH entry. |

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `package_name` | String | platform default | Package name for package installs. |
| `package_version` | String | `nil` | Package version for package installs. |
| `package_action` | Symbol | `:install` | Action passed to the package resource during `:install`. |
| `source_checksum` | String | Git 2.54.0 tarball checksum | Source tarball checksum. |
| `source_prefix` | String | `'/usr/local'` | Prefix used by `make install`. |
| `source_url` | String | kernel.org source tarball URL for `source_version` | Source tarball URL. |
| `source_use_pcre` | true, false | `false` | Build Git with PCRE support. |
| `source_version` | String | `'2.54.0'` | Git source version to build. |
| `windows_architecture` | String | detected from kernel machine | Windows installer architecture: `32`, `64`, or `arm64`. |
| `windows_display_name` | String | `"Git version <version>"` | Display name used by `windows_package`. |
| `windows_package_url` | String | Git for Windows release URL | Installer URL. |
| `windows_package_checksum` | String | `nil` | Optional installer checksum. |
| `windows_package_version` | String | `'2.54.0'` | Git for Windows version. |

## Examples

### Package install

```ruby
git_client 'default'
```

### Source install

```ruby
git_client 'source' do
  source_version '2.54.0'
  action :install_from_source
end
```

### Windows install

```ruby
git_client 'default' do
  windows_package_version '2.54.0'
  windows_architecture '64'
end
```
