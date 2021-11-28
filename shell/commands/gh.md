# gh

[Manual | GitHub CLI](https://cli.github.com/manual/)

GitHubの操作をCLIで行うことができる。

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
