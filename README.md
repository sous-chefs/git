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

### Chef

- Chef 15.3+

### Cookbooks

- ark (for `git_client` source install)

## Usage

Include `git::default`, `git::windows`, or `git::source` in your cookbook OR use the `git_client` resource directly.

## Resources Overview

- [`git_client`](./documentation/git_client.md): Manages a Git client installation on a machine. Source install action is available on Linux.
- [`git_config`](./documentation/git_config.md): Sets up Git configuration on a node.

## Recipes

This cookbook ships with ready to use, attribute driven recipes that utilize the `git_client` and `git_service` resources. As of cookbook 4.x, they utilize the same attributes layout scheme from the 3.x. Due to some overlap, it is currently impossible to simultaneously install the Git client as a package and from source by using the "manipulate the node attributes and run a recipe" technique. If you need both, you'll need to utilize the git_client resource in a recipe.

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
