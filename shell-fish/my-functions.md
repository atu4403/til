# my functions

fishのオリジナル関数。

## words

英単語のスペルがうろ覚えの時に辞書から探してコピーする

```bash
function words
    cat /usr/share/dict/words | fzf | pbcopy
end
```

> `pbcopy`はmacosのコピー用コマンドです。
> 環境に応じて`clip.exe`や`xclip`等に書き換えて下さい

## names

適当な名前が欲しい時に探してコピーする

```bash
function names
    cat /usr/share/dict/propernames | fzf | pbcopy
end
```

## see

ghqで選んだリポジトリをブラウザで開く

> ghqとgh-cliをインストールしている必要があります
> 
> - [x-motemen/ghq: Remote repository management made easy](https://github.com/x-motemen/ghq)
> - [cli/cli: GitHub’s official command line tool](https://github.com/cli/cli)

```bash
function see
    ghq list --full-path | fzf | read foo
    and set -l ghq_path (string split '/' $foo)
    and gh repo view --web "$ghq_path[-2]/$ghq_path[-1]"
end
```

## cde

cdで移動して`exa`で一覧を表示。

> exaをインストールしている必要があります
>
> - [ogham/exa: A modern replacement for ‘ls’.](https://github.com/ogham/exa)
>
> exaを使わない場合は`and exa~`の行を`and la`に書き換えればOKです。

```bash
function cde
    cd $argv
    and exa -ahl@ --time-style=long-iso --icons
end
```

`and exa -ahl@ --time-style=long-iso --icons`を`and la`に書き換えればexaが無くてもOKです。

## ccd

fzfを使ったcd。絞り込んで深い階層まで一気に移動する。
fdを使っているので`.gitignore`に指定されているものは対象外になる。

ただし$HOME等で使うと対象が多くて時間がかかる。

> fdをインストールしている必要があります
>
> - [sharkdp/fd: A simple, fast and user-friendly alternative to 'find'](https://github.com/sharkdp/fd)

```bash
function ccd
    fd --type d | fzf | read foo
    and cde $foo
end
```

上で紹介した`cde`を使っています。`cde`を`cd`に書き換えても動作します。

## zz

zにfzfを食わせる。移動先で`ls`的に一覧を表示。

> fishプラグインの`z`が必要です
>
> - [jethrokuan/z: Pure-fish z directory jumping](https://github.com/jethrokuan/z)

```bash
function zz
    z --list | fzf | read foo
    and set foo (string split ' ' $foo)
    and cde $foo[-1]
end
```

上で紹介した`cde`を使っています。`cde`を`cd`に書き換えても動作します。
