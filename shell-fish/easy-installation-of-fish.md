# WIP

<!-- # zshからfishへの移行ガイド -->

**fish shell**のインストールや初期設定の解説サイトは多数ありますが、以下の点に難があります。

- 現在使っているshell(bashやzsh)の設定を捨てて、新たにfish流の設定をする事が前提になっている
- 「プラグインマネージャの**fisher**を使いましょう」って言われても使いたくない

fishは未設定でも補完が凄いけど、現在のshellで使ってる`bat`や`exa`は未設定では使えません。それがわかった瞬間にfishを投げ捨てたくなります。
また、**fisher**使えとの解説が当たり前過ぎて「じゃあfisherって具体的に何してくれるの?」と解説したサイトはあまりありません。

この記事では「現在のshellでの設定を引き継ぐ方法」「設定しなくてもできること」を極力「fisherを使わずに」解説していきたいと思います。

## config.fishの確認

この記事ではfishのインストール方法には触れません。
fishがインストール済みか確認のためshellに`fish`と打ち込んでください。

```bash
> fish
Welcome to fish, the friendly interactive shell
Type help for instructions on how to use fish
```

上のようになればfishはインストールされています。

次に設定ディレクトリを確認します。

```bash
ls ~/.config/fish
```

表示の中に`config.fish`があればOKです。zshの`.zshrc`に代わる設定ファイルです。もし`No such file or directory`と出たら以下のコマンドを入力してください。

```bash
echo $__fish_config_dir
```

表示されるパスがfishの設定ディレクトリになります。

※ 以降は設定ディレクトリが`~/.config/fish`にあるものとして話を進めます。

## pathを通す

現在のshellで使ってる`bat`や`exa`が使えないのはpathが通ってないからです。とはいえ`.zshrc`を開いてあちこちに散らばっているpath設定を探すのは面倒です。

カンタンな方法として、以下のコマンドを**現在のshell(bash,zsh)で**打ち込んでください。

```bash
echo $PATH|awk -v 'RS=:' '{printf("set -x PATH %s $PATH\n", $1)}'|tac
```

以下のような出力がありますので、`~/.config/fish/config.fish`にコピペしてください。

```bash
set -x PATH /Users/atu/bin $PATH
set -x PATH /Users/atu/go/bin $PATH
set -x PATH /Users/atu/.nodebrew/current/bin $PATH
set -x PATH /Applications/Wireshark.app/Contents/MacOS $PATH
set -x PATH /opt/X11/bin $PATH
set -x PATH /Library/TeX/texbin $PATH
set -x PATH /sbin $PATH
set -x PATH /usr/sbin $PATH
set -x PATH /bin $PATH
set -x PATH /usr/bin $PATH
set -x PATH /usr/local/bin $PATH
set -x PATH /Users/atu/.rbenv/shims $PATH
set -x PATH /Users/atu/bin $PATH
set -x PATH /Users/atu/.pyenv/shims $PATH
set -x PATH /Users/atu/.goenv/bin $PATH
set -x PATH /Users/atu/.goenv/shims $PATH
set -x PATH /Users/atu/.volta/bin $PATH
```

この設定により、fishでも使い慣れたコマンドが使えるようになります。

<!-- - 変数は配列 -->


## zshrcの中身について

そもそも`.zshrc`って何を書いているのでしょうか。だいたい以下のような感じだと思います。

- PATHの設定
- プロンプトの設定
- 補完の設定
- aliasを定義
- 関数を定義
- historyの設定
- ls等の色の設定
- その他の設定

PATHの設定は終わったので他の項目について紹介していきます。

## プロンプトの設定

fishシェルに`fish_config`と打ち込むと、ブラウザでfishの設定画面が開きます。

1. `prompt`のタブに移ります
2. 好きなデザインのプロンプトをクリックします
3. `Set Prompt`をクリックすると設定完了です
4. 新しいfishシェルを開くと反映されます

![fish-setting-prompt](/images/easy-installation-of-fish/2021-12-02-17-31-49.png)

もしこの中のものでは物足りなく、自己流にカスタマイズしたいなら`関数の定義`までお付き合いください。

## 補完の設定

fishシェルから`git add -`と打ち、`tab`キーを押してみてください。

```txt
> git add --help
-A  --all                        (Match files both in working tree and index)
-e  --edit                                          (Manually create a patch)
-f  --force                            (Allow adding otherwise ignored files)
-i  --interactive                                          (Interactive mode)
-N  --intent-to-add  (Record only the fact that the path will be added later)
-n  --dry-run                                (Don't actually add the file(s))
-p  --patch                             (Interactively choose hunks to stage)
-u  --update                                       (Only match tracked files)
-v  --verbose                                                    (Be verbose)
--help                                  (Display the manual of a git command)
--ignore-errors                                               (Ignore errors)
--ignore-missing           (Check if any of the given files would be ignored)
--refresh                (Don't add the file(s), but only refresh their stat)
```

補完候補が出てきました。そうなんです。fishは何も設定しなくてもgitの補完ができるんです。

他にどんな補完設定が最初から使えるか確認するには以下のコマンドを打ちます。

```bash
la $__fish_data_dir/completions/
```

fzfやpecoがインストール済みならpipeで繋いでみてください。

```bash
la $__fish_data_dir/completions/ | fzf
```

- npm
- node
- python
- ruby
- go
- brew
- vim
- emacs
- atom

その他700以上の補完設定ファイルがあります。(fish v3.3.1の時点)

まずは十分だと思います。それでも独自の補完設定を追加したい場合は他記事を参照ください。

## aliasを定義

aliasの説明の前に、↑で入力したコマンドをもう一度見てください。`la`が使われています。

`la`というコマンドは本来存在しないのですが、zsh使いにとっては最初に設定するaliasだと思います。
しかしfishでは最初から設定されています。

ただ、fishではaliasではなく関数になっています。確認してみましょう。

```bash
> functions la
# Defined in /usr/local/Cellar/fish/3.3.1/share/fish/functions/la.fish @ line 4
function la --wraps=ls --description 'List contents of directory, including hidden files in directory using long format'
    ls -lah $argv
end
```

`la`コマンドの中身は`ls -lah`だとわかります。

fishにも`alias`というコマンドは存在するのですが、実態はfunctionを作成するラッパーです。公式では「互換性のためにaliasも使えるようにしてるけど、できればfunctionを使ってね」と言っています。

[alias - create a function — fish-shell 3.3.1 documentation](file:///usr/local/Cellar/fish/3.3.1/share/doc/fish/cmds/alias.html)

また、aliasの代わりに`abbr`を使うと便利です。私は`abbr`がaliasの代わりとして十分だと思いますのでaliasの説明は以上になります。

使い方は次項に書いてますので検討してみてください。

## abbrの定義

まずは以下のコマンドを打ってください。

```bash
abbr --add s git status
```

次に`s⏎`と打ってください。`git status`が実行されます。

`abbr` = aliasだと考えてしまいそうですがちょっと違います。

今度は`s`と入力した後にスペースを押してください。`s`が`git status`に変わります。

つまり`abbr`は短縮名の設定です。スペースで展開、enterで展開+実行を行います。
展開だけで止められるので`s`の後にスペースを押した後で`--short`のようにオプションや引数を加えることができます。

従来のaliasだと`s --short`と`git status --short`は別のコマンドとしてhistoryに書き込まれます。

`abbr`だと`s` + `space`の時点で展開しますので`s`や`s --short`というコマンド履歴はhistoryに残りません。

| キーワード後の入力 | 処理      |
|:-------------|:--------|
| space        | 展開      |
| enter        | 展開+実行 |

`abbr --add`で登録したものは`~/.config/fish/fish_variables`に書き込まれ、永続化されます。自分で`config.fish`に書き加える必要はありません。

```bash
SETUVAR _fish_abbr_s:git\x20status
```

最後に`abbr`コマンドのオプション一覧を載せておきます。

| オプション      | 機能            |
|:-----------|:--------------|
| -a --add   | 新規作成        |
| -h --help  | help表示        |
| -s --show  | 登録したabbrの一覧 |
| -e --erase | 登録削除        |
| -l --list  | 短縮名の一覧     |

## 関数を定義

`abbr`は便利ですが、コマンドの途中に引数を挟むことはできません。

例えば`ls`の出力をfzfやpecoに渡すには以下のように書きます。

```bash
# fzf
ls 引数 | fzf
# peco
ls 引数 | peco
```

これをalias的に使える関数`lf`を作ってみましょう。

コマンドラインに`functioon lf`と打ち込んで`enter`を押してください。

するとコマンドは続きの入力を求めます。`end`と入力するまで続くので、以下のように入力してください。

```bash
> function lf
      ls $argv | fzf
  end
```

これで関数`lf`が作成できました。`$argv`は引数を取ります。

引数が無い場合`$argv`は空文字列になりますので`ls | fzf`として扱われます。

`lf /path/to`のようにpathを指定すると、`ls /path/to | fzf`と実行されます。

しかしこのままではシェルを閉じると関数は消えてしまいます。永続化するには以下のようにします。

```bash
funcsave lf
```

これにより`~/.config/fish/functions/lf.fish`というファイルが作成されて`lf`関数は永続化されます。確認してみましょう。

```bash
> cat ~/.config/fish/functions/lf.fish
function lf
ls $argv | fzf
end
```

もちろん`~/.config/fish/functions/`以下に直接fileを作成しても構いませんが、簡単なものならコマンドラインから行ったほうが楽です。

ただし`funcsave`は忘れないように。

---

さて、冒頭で説明したプロンプトの設定はしましたか？実はプロンプトも関数によって制御されています。

`~/.config/fish/functions/fish_prompt.fish`がプロンプトの定義ファイルです。これを編集することでオリジナルのプロンプトを作成できます。

単純な例では以下の設定でオリジナルのプロンプトが作成できます。

```bash
function fish_prompt
    echo ☆彡
end
```

また、`~/.config/fish/functions/fish_right_prompt.fish`は右のプロンプトになります。

## historyの設定

zshでは色々とhistoryの設定がありました。

- HISTFILEの場所
  - `$__fish_user_data_dir/fish_history`
- 保存数
  - 約26万行 ※1
- 重複を許可しない
  - ○
- スペースで始まるものはhistoryに追加しない
  - ○
- すぐhistoryに追加する
  - ×
- プロセス間での共用
  - ×
- 追加するコマンドが過去にあったら古い方を削除
  - ○
- histroryコマンドは除外
  ×

|                   |   |
|:------------------|:--|
| HISTFILEの場所     |   |
| 保存数            |   |
| 重複を取り除く       |   |
| スペースで始まるものは除外  |   |
| すぐファイルに追加する     |   |
| プロセス間での共用      |   |
| 重複は古い方を削除   |   |
| histroryコマンドは除外 |   |

[※1 Config for fish history length · Issue #2674 · fish-shell/fish-shell](https://github.com/fish-shell/fish-shell/issues/2674)


- ls等の色の設定
- その他の設定