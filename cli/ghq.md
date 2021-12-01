# ghq

gitリポジトリ集中管理ツール

※正確にはいろいろなVCSを使えるらしいが、gitしか使ってないので

- 作成はcreate or get
  - getでcloneしてくる
  - createは新規に作成

## create

リポジトリ名を指定すればdefaultの場所までディレクトリを掘って`git init`する

```bash
❯ ghq create til
    git init
Initialized empty Git repository in /Users/atu/ghq/github.com/atu4403/til/.git/
/Users/atu/ghq/github.com/atu4403/til
```

## fish-ghq

[til fish-ghq](../fish/fish-ghq.md)

[decors/fish-ghq: ghq completion and keybinding for fish shell](https://github.com/decors/fish-ghq)

fishプラグイン。fzfでghqの管理リポジトリを移動できる。

ショートカットキー`ctrl-g`で発火。並んだリポジトリを選択すればそのディレクトリまで移動する
