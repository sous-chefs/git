# Git Cookbook

[![Cookbook Version](https://img.shields.io/cookbook/v/git.svg)](https://supermarket.chef.io/cookbooks/git)
[![CI State](https://github.com/sous-chefs/git/workflows/ci/badge.svg)](https://github.com/sous-chefs/git/actions?query=workflow%3Aci)
[![OpenCollective](https://opencollective.com/sous-chefs/backers/badge.svg)](#backers)
[![OpenCollective](https://opencollective.com/sous-chefs/sponsors/badge.svg)](#sponsors)
[![License](https://img.shields.io/badge/License-Apache%202.0-green.svg)](https://opensource.org/licenses/Apache-2.0)

Installs git_client from package or source. Optionally sets up a git service under xinetd.

## Scope

This cookbook is concerned with the Git SCM utility. It does not address ecosystem tooling or related projects.

## Maintainers

This cookbook is maintained by the Sous Chefs. The Sous Chefs are a community of Chef cookbook maintainers working together to maintain important cookbooks. If you’d like to know more please visit [sous-chefs.org](https://sous-chefs.org/) or come chat with us on the Chef Community Slack in [#sous-chefs](https://chefcommunity.slack.com/messages/C2V7B88SF).

## Requirements

### Platforms

The following platforms have been tested with Test Kitchen:

```
|---------------+-------|
| amazonlinux-2 | X     |
|---------------+-------|
| centos-7      | X     |
|---------------+-------|
| centos-8      | X     |
|---------------+-------|
| fedora        | X     |
|---------------+-------|
| debian-9      | X     |
|---------------+-------|
| debian-10     | X     |
|---------------+-------|
| ubuntu-16.04  | X     |
|---------------+-------|
| ubuntu-18.04  | X     |
|---------------+-------|
| ubuntu-20.04  | X     |
|---------------+-------|
| openSUSE Leap | X     |
|---------------+-------|
```

### Chef

- Chef 14+

### Cookbooks

- none

## Usage

Add `git::default`, `git::source` or `git::windows` to your run_list OR add `depends 'git', '~> 4.3'` to your cookbook's metadata.rb. include_recipe one of the recipes from your cookbook OR use the git_client resource directly, the same way you'd use core Chef resources (file, template, directory, package, etc).

## Resources Overview

- `git_client`: Manages a Git client installation on a machine. Acts as a singleton when using the (default) package provider. Source provider available as well.
- `git_service`: Sets up a Git service via xinetd. WARNING: This is insecure and will probably be removed in the future
- `git_config`: Sets up Git configuration on a node.

### git_client

The `git_client` resource manages the installation of a Git client on a machine.

`Note`: on macOS systems homebrew must first be installed on the system before running this resource. Prior to version 9.0 of this cookbook homebrew was automatically installed.

#### Example

```ruby
git_client 'default' do
  action :install
end
```

#### Example of source install

```ruby
git_client 'source' do
  provider Chef::Provider::GitClient::Source
  source_version '2.14.2'
  source_checksum 'a03a12331d4f9b0f71733db9f47e1232d4ddce00e7f2a6e20f6ec9a19ce5ff61'
  action :install
end
```

### git_config

The `git_config` resource manages the configuration of Git client on a machine.

#### Example

```ruby
git_config 'url.https://github.com/.insteadOf' do
  value 'git://github.com/'
  scope 'system'
  options '--add'
end
```

#### Properties

Currently, there are distinct sets of resource properties, used by the providers for source, package, macos, and windows.

# used by linux package providers

- `package_name` - Package name to install on Linux machines. Defaults to a calculated value based on platform.
- `package_version` - Defaults to nil.
- `package_action` - Defaults to `:install`

# used by source providers

- `source_prefix` - Defaults to '/usr/local'
- `source_url` - Defaults to a calculated URL based on source_version
- `source_version` - Defaults to 2.8.1
- `source_use_pcre` - configure option for build. Defaults to false
- `source_checksum` - Defaults to a known value for the 2.8.1 source tarball

# used by the Windows package providers

- `windows_display_name` - Windows display name
- `windows_package_url` - Defaults to the Internet
- `windows_package_checksum` - Defaults to the value for 2.8.1

## Recipes

This cookbook ships with ready to use, attribute driven recipes that utilize the `git_client` and `git_service` resources. As of cookbook 4.x, they utilize the same attributes layout scheme from the 3.x. Due to some overlap, it is currently impossible to simultaneously install the Git client as a package and from source by using the "manipulate a the node attributes and run a recipe" technique. If you need both, you'll need to utilize the git_client resource in a recipe.

## Attributes

### Windows

- `node['git']['version']` - git version to install
- `node['git']['url']` - URL to git package
- `node['git']['checksum']` - package SHA256 checksum
- `node['git']['display_name']` - `windows_package` resource Display Name (makes the package install idempotent)

### Linux

- `node['git']['prefix']` - git install directory
- `node['git']['version']` - git version to install
- `node['git']['url']` - URL to git tarball
- `node['git']['checksum']` - tarball SHA256 checksum
- `node['git']['use_pcre']` - if true, builds git with PCRE enabled

## Contributors

This project exists thanks to all the people who [contribute.](https://opencollective.com/sous-chefs/contributors.svg?width=890&button=false)

### Backers

Thank you to all our backers!

![https://opencollective.com/sous-chefs#backers](https://opencollective.com/sous-chefs/backers.svg?width=600&avatarHeight=40)

### Sponsors

Support this project by becoming a sponsor. Your logo will show up here with a link to your website.

![https://opencollective.com/sous-chefs/sponsor/0/website](https://opencollective.com/sous-chefs/sponsor/0/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/1/website](https://opencollective.com/sous-chefs/sponsor/1/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/2/website](https://opencollective.com/sous-chefs/sponsor/2/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/3/website](https://opencollective.com/sous-chefs/sponsor/3/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/4/website](https://opencollective.com/sous-chefs/sponsor/4/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/5/website](https://opencollective.com/sous-chefs/sponsor/5/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/6/website](https://opencollective.com/sous-chefs/sponsor/6/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/7/website](https://opencollective.com/sous-chefs/sponsor/7/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/8/website](https://opencollective.com/sous-chefs/sponsor/8/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/9/website](https://opencollective.com/sous-chefs/sponsor/9/avatar.svg?avatarHeight=100)
