# fish - ディレクトリを表す変数の調査

fishには`__fish`ではじまり`dir`で終わる変数が6つ設定されている。このディレクトリに何が含まれているのかを調べた記録。

* __fish_bin_dir
* __fish_data_dir
* __fish_user_data_dir
* __fish_sysconf_dir
* __fish_config_dir
* __fish_help_dir

## $__fish_bin_dir

```bash
> tree -aLF 2 --dirsfirst $__fish_bin_dir
/usr/local/Cellar/fish/3.3.1/bin
├── fish*
├── fish_indent*
└── fish_key_reader*
```

fish独自の関数(?)全てバイナリ。

### fish_indent

fishファイルを整形して、元のファイルの書き換えやhtml出力をするコマンド。

[fish_indent:fishスクリプトを整形する5つの方法](http://fish.rubikitch.com/fish_indent/)

```bash
> fish_indent -w ~/.config/fish/functions/words.fish

> functions words
# Defined in /Users/atu/.config/fish/functions/words.fish @ line 1
function words
    cat /usr/share/dict/words | fzf | pbcopy
end
```

`cat /usr/share/dict/words | fzf| pbcopy`だったのが
`cat /usr/share/dict/words | fzf | pbcopy`に整形された。

### fish_key_reader

`bind`でキーバインドを設定するときの書き方を教えてくれるコマンド？

実行すると入力待ちになるのでキーを押すと結果が出る。そのキーに何かがバインドされているか否かはわからない様子。

```bash
Press a key: # ctrl - alt - gを押した場合
              hex:   1B  char: \c[  (or \e)
(  0.102 ms)  hex:    7  char: \cG  (or \a)
bind \e\a 'do something'
```

```bash
Press a key: # ctrl - cを押した場合
              hex:    3  char: \cC
Press [ctrl-C] again to exit
bind \cC 'do something'
```

## __fish_data_dir

```bash
> tree -aLF 1 --dirsfirst $__fish_data_dir
/usr/local/Cellar/fish/3.3.1/share/fish
├── completions/
├── functions/
├── groff/
├── man/
├── tools/
├── vendor_completions.d/
├── vendor_conf.d/
├── vendor_functions.d/
├── __fish_build_paths.fish
├── config.fish
└── lynx.lss

8 directories, 3 files
```

### completions

補完設定。git, npm等有名どころが780ファイル。

### functions

関数。ls, ll, la, cdからfish独自関数まで217ファイル

### groff

`groff/fish.tmac`というファイルが１つ。`groff`というコマンドに関する何か？

### man

manを生成する何か？`abbr.1`,`cd.1`というような名前の120ファイル

### vendor_*

全て空のディレクトリ

* vendor_completions.d
* vendor_conf.d
* vendor_functions.d

### __fish_build_paths.fish

↑の`vendor_*`ディレクトリを変数に登録してる。

### config.fish

`$__fish_initialized`の設定をしている？

### lynx.lss

Lynx(テキストベースのhtmlブラウザ)のcssみたいなもん？

[Lynx (ウェブブラウザ) - Wikiwand](https://www.wikiwand.com/ja/Lynx_%28%E3%82%A6%E3%82%A7%E3%83%96%E3%83%96%E3%83%A9%E3%82%A6%E3%82%B6%29)

## __fish_user_data_dir

```bash
❯tree -aLF 1 --dirsfirst $__fish_user_data_dir
/Users/atu/.local/share/fish
├── generated_completions/
└── fish_history
```

### generated_completions

生成された補完？

`git.fish`から`git-push.fish`等の派生、`mysql.fish`から`mysqldump.fish`等の派生、`passwd.fish`や`sed.fish`や`ssh.fish`等など1338ファイル

## fish_history

historyファイル？以下のような形式

```bash
- cmd: cd ~/Documents/scripts/
  when: 1637556052
```

## __fish_sysconf_dir

```bash
> tree -aLF 1 --dirsfirst $__fish_sysconf_dir
/usr/local/Cellar/fish/3.3.1/etc/fish
└── config.fish

0 directories, 1 file
```

1ファイルのみ。

### $__fish_sysconf_dir/config.fish

```bash
> cat config.fish
# Put system-wide fish configuration entries here
# or in .fish files in conf.d/
# Files in conf.d can be overridden by the user
# by files with the same name in $XDG_CONFIG_HOME/fish/conf.d

# This file is run by all fish instances.
# To include configuration only for login shells, use
# if status is-login
#    ...
# end
# To include configuration only for interactive shells, use
# if status is-interactive
#   ...
# end
```

## __fish_config_dir

いつものやつ。`~/.config/fish`

## その他path

```bash
> echo $fish_function_path|tr ' ' '\n'
/Users/atu/.config/fish/functions
/usr/local/Cellar/fish/3.3.1/etc/fish/functions
/usr/local/Cellar/fish/3.3.1/share/fish/vendor_functions.d
/usr/local/share/fish/vendor_functions.d
/usr/local/Cellar/fish/3.3.1/share/fish/functions
```

おそらく、コマンドを実行すると`$fish_function_path`をこの順番で探して最初に見つかったものを実行する。

例えば`cd`コマンドは最初から定義されているが、userが`cd`コマンドを定義するとそれが使われる。

探索順は[公式のドキュメント](https://fishshell.com/docs/current/language.html?highlight=autoload#autoloading-functions)と一致する。

補完のpathをまとめた変数もあった。

```bash
echo $fish_complete_path |tr ' ' '\n'
/Users/atu/.config/fish/completions
/usr/local/Cellar/fish/3.3.1/etc/fish/completions
/usr/local/Cellar/fish/3.3.1/share/fish/vendor_completions.d
/usr/local/share/fish/vendor_completions.d
/usr/local/Cellar/fish/3.3.1/share/fish/completions
/Users/atu/.local/share/fish/generated_completions
```
