# git_config

The `git_config` resource manages the configuration of Git client on a machine.

## Actions

| Action | Description |
|--------|-------------|
| `:set` | Sets a Git config key to the requested value. Default. |
| `:unset` | Removes all values for a Git config key in the requested scope. |

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `key` | String | name property | Git configuration key. |
| `value` | String | `nil` | Git configuration value. Required for `:set`. |
| `scope` | String | `'global'` | Config scope: `local`, `global`, `system`, or `file`. |
| `config_file` | String | `nil` | Config file used with `scope 'file'`. |
| `path` | String | `nil` | Working directory for local config operations. |
| `user` | String | `nil` | User for the git config command. |
| `group` | String | `nil` | Group for the git config command. |
| `password` | String | `nil` | Password for Windows elevated execution. Sensitive. |
| `options` | String | `nil` | Additional options appended to the set command, such as `--add`. |

## Examples

### Set a system value

```ruby
git_config 'url.https://github.com/.insteadOf' do
  value 'git://github.com/'
  scope 'system'
  options '--add'
end
```

### Unset a global value

```ruby
git_config 'user.name' do
  action :unset
end
```
