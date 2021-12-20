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

## repo create

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

## pr create

プルリクエスト作成

- 現在のブランチからプルリクの作成
- リモートにpushしていない場合は確認を求められる
- `--fill`オプションでtitle,bodyをコミットメッセージから反映させる
- push済みで`--fill`を付けると確認なしで作成

```bash
> gh pr create --fill

Creating pull request for date_util into main in atu4403/adash

https://github.com/atu4403/adash/pull/1
```

## pr merge

プルリクエストをmergeする

- `-m --merge`でno-ffマージ?(違うかも)
- `--rebase`や`--squash`でも可
- `-d`で旧ブランチを削除

```bash
> gh pr merge date_util -dm --body "update v$new_ver"
✓ Merged pull request #1 (date util)
remote: Enumerating objects: 1, done.
remote: Counting objects: 100% (1/1), done.
remote: Total 1 (delta 0), reused 0 (delta 0), pack-reused 0
Unpacking objects: 100% (1/1), 622 bytes | 622.00 KiB/s, done.
From https://github.com/atu4403/adash
 * branch            main       -> FETCH_HEAD
   6092be8..159c213  main       -> origin/main
Updating 6092be8..159c213
Fast-forward
 dist/adash-0.2.0-py3-none-any.whl | Bin 0 -> 5918 bytes
 dist/adash-0.2.0.tar.gz           | Bin 0 -> 5107 bytes
 pyproject.toml                    |   2 +-
 src/adash/__init__.py             |   1 +
 src/adash/date_util.py            |  34 ++++++++++++++++++++++++++++++++++
 tests/test_date_list.py           |  22 ++++++++++++++++++++++
 6 files changed, 58 insertions(+), 1 deletion(-)
 create mode 100644 dist/adash-0.2.0-py3-none-any.whl
 create mode 100644 dist/adash-0.2.0.tar.gz
 create mode 100644 src/adash/date_util.py
 create mode 100644 tests/test_date_list.py
✓ Deleted branch date_util and switched to branch main
```

## release create

releaseの作成(tagがないなら付ける)

- filesを指定しなくてもバイナリを自動で選んでくれる
- titleなしならマージコミットのmessage?

```bash
> gh release create v0.2.0
? Title (optional)
? Release notes Leave blank
? Is this a prerelease? No
? Submit? Publish release
```
