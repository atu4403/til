# gh

[Manual | GitHub CLI](https://cli.github.com/manual/)

GitHubの操作をCLIで行うことができる。

## gh config

gh独自の設定。`.gitconfig`とは関係なく`~/.config/gh/config.yml`に保存されている。

`gh config set editor "code --wait"`でeditorにvscodeを設定した後の`config.yml`が以下。

```~/.config/gh/config.yml
# What protocol to use when performing git operations. Supported values: ssh, https
git_protocol: https
# What editor gh should run when creating issues, pull requests, etc. If blank, will refer to environment.
editor: !!null code --wait
# When to interactively prompt. This is a global config that cannot be overridden by hostname. Supported values: enabled, disabled
prompt: enabled
# A pager program to send command output to, e.g. "less". Set the value to "cat" to disable the pager.
pager:
# Aliases allow you to create nicknames for gh commands
aliases:
    co: pr checkout
    see: browse
# The path to a unix socket through which send HTTP connections. If blank, HTTP traffic will be handled by net/http.DefaultTransport.
http_unix_socket:
# What web browser gh should use when opening URLs. If blank, will refer to environment.
browser:
```

## gh repo create

現在のDirectoryからGitHubにリポジトリを作成する。`hub`コマンドと違って対話形式で`description`や公開範囲を指定できて便利。

```bash
❯ gh repo create
? Repository name til
? Repository description til - Today I learned.
? Visibility Public
? This will add an "origin" git remote to your local repository. Continue? Yes
✓ Created repository atu4403/til on GitHub
✓ Added remote https://github.com/atu4403/til.git
```
