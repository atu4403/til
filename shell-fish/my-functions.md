# fishのオリジナル関数

これらの関数を使いたい場合は、そのままfishシェルにコピペで登録できます。（詳しくは後半）

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

## fishで自作関数を作るベストプラクティス

### $EDITOR

ターミナルからいつものエディタを開くために設定します。

`~/.config/fish/conf.d/setup_editor.fish`というファイルを作り以下を記述

```bash
switch (uname)
    case Darwin
        if test -e /usr/local/bin/code
            set -x EDITOR /usr/local/bin/code --wait
        end
end
```

`config.fish`に書いても良いですし、`set -x EDITOR`の行だけでも大丈夫です。

上記はvscodeの例ですが、好きなエディタを設定してください。

### 関数の作成

fishシェルでfunctionコマンドから作成するのが楽です。

`function 関数名`で`enter`すると続きの入力をを求められます。とりあえずのコードを書き、`end`と入力すれば関数が作成されます。

```bash
function hello
              echo hello $argv
          end
```

これでとりあえずの関数ができたので実行できます。

```bash
> hello world
hello world
```

### 編集

`funced 関数名`で編集できます。変数EDITORに設定しているエディタで開くので、保存して閉じると編集が終了します。

```bash
> funced hello
# エディタで保存して閉じると制御が戻ります
```

### 永続化

このままではシェルを閉じると消えてしまいます。`funcsave 関数名`で永続化します。

```bash
> funcsave hello
```

これで`~/.config/fish/functions/hello.fish`が作成されます。

`funcsave`が手間になるなら`funced`と`funcsave`を一気に行う関数を作成します。↓をそのままコマンドラインにコピペするだけでOKです。

```bash
function fed --description http://fish.rubikitch.com/fed-funced-funcsave/
    funced $argv[1]; and funcsave $argv[1]
end
```

これも`funcsave fed`としなければ永続化しないので注意してください。

[fed:【要注意】外部エディタで関数定義し永続化する](http://fish.rubikitch.com/fed-funced-funcsave/)
