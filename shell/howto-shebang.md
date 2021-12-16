# shebang（シバン）について最低限覚えておきたいこと

shebang(シバン、シェバン)について完全に理解した[^1]のでまとめてみます。

> シバンはOSによって挙動が違います。本記事ではmacosにて検証を行っています。
> windowsの場合は参考にならないと思います。

シバンは「実行可能なファイル」を「実行」させた時にインタプリタを指定するものです。

```bash
echo sleep 2 > test_file
chmod +x test_file
./test_file
```

これで`test_file`が実行されて2秒後に終了します。シバンは付いていません。

どのインタプリタで実行されているのかは`iterm2`の`Toolbelt` > `jobs`で確認しました。
(常に`fish`が表示されていますが、これはshellが`fish`なので関係ありません)

![alt](../images/howto-shebang/jobs.gif)

シバンが無い状態では`sh`で実行されています。

`test_file`にシバンを追加してみます。

```bash
#!/bin/bash
sleep 2
```

これを`./test_file`として起動すると`bash`で実行されます。同様に`bash`を`zsh`や`csh`に変えるとそれぞれのインタプリタで実行されます。

## コマンドとしてのインタプリタ

シバンが`#!/bin/bash`のファイルだとしても、「kshコマンドで実行」するとインタプリタは`ksh`になります。

```bash
ksh test_file
```

シバンは無視されています。しかしこの場合`ksh`はコマンドで`test_file`は引数なので当たり前と言えば当たり前です。シバンは「実行可能なファイル」を「実行」させた時にインタプリタを指定するものなので、他のコマンド(この場合は`ksh`)から呼び出す場合は無視されます。

## じゃあ`bash test_file`で良くね？

`#!/bin/bash`と付けたファイルは`bash test_file`と同義になります。

しかし`test_file`はコマンドです。`bash test_file`で動くとしても、`bash`で動くスクリプトであるかどうかコマンドを使うユーザーは知りません。しかしシバンで書いてあることにより`test_file`は`bash`で動くものだと自動的に判別して実行できるのでシバンは必要です。

## フルパス指定すりゃいいの？

このふるまいを見ると`シバン=コマンドのフルパス指定`と解釈しそうですがちょっと違います。

私の環境で`ruby`は`/Users/atu/.rbenv/shims/ruby`を指しています。

```bash
> which ruby
/Users/atu/.rbenv/shims/ruby
```

これをそのままシバンに設定しても無視されて`sh`で動作します。

```bash
#!/Users/atu/.rbenv/shims/ruby
sleep 2
```

これは`/Users/atu/.rbenv/shims/ruby`がスクリプトだからです。
シバンで指定したものがバイナリでなければ無視されるようです。

```bash
> cat /Users/atu/.rbenv/shims/ruby
#!/usr/bin/env bash
set -e
[ -n "$RBENV_DEBUG" ] && set -x
# 中略
export RBENV_ROOT="/Users/atu/.rbenv"
exec "/usr/local/bin/rbenv" exec "$program" "$@"
```

`ruby`で実行するには以下のようにします。

```bash
#!/usr/bin/env ruby
sleep 2
```

ちなみに私の環境では`nodejs`の管理に[Volta](https://volta.sh/)を使用しています。これはバイナリを指すのでそのまま実行できました。

```bash
#!/Users/atu/.volta/bin/node
console.log('hello node')
```

もちろん`#!/usr/bin/env node`でも実行できますし、シバンを削除すると`sh`で動くので`console.log`が理解できなくてエラーになります。

ここで疑問。nodejs( ≒ javascript)では`#`をコメントと認識しないので、シバン付きのファイルを`node`コマンドで実行するとエラーになるのでは？と思いやってみました。エラーは出ませんでした。

つまり「1行目が`#!`で始まるのなら無視する」という機能が`node`コマンドに備わっているのだと思います。
その仮定で実験してみます。

`node_test`

```bash
#!/bin/bash
console.log('hello node')
```

| シバン                 | 実行             | 結果                      |
|:--------------------|:-----------------|:--------------------------|
| #!/usr/bin/env node | `./node_test`    | ○                         |
| #!/bin/bash         | `./node_test`    | × (bashではconsole.logがエラー) |
| #!/bin/bash         | `node node_test` | ○ (シバンは無視)              |
| #/bin/bash          | `node node_test` | × (nodeでは#で始まる行はエラー)    |
| #/bin/bash          | `bash node_test` | × (console.logがエラー)       |

ちなみに最後の`bash node_test`ではシバンの記述ミスにエラーは出ず、2行目でエラーになっています。`#`はコメントとして解釈されたようです。このふるまいは`zsh`, `csh`, `ksh`も同じでした。

## シバンは必要なの？不必要なの？

検証により以下の事がわかりました。

- ファイルに実行権限を与えて実行する場合はシバンが必要
- ただし`sh`で実行する場合は不要
- 実行コマンド(`bash`, `zsh`, `node`等)ではシバンを無視するので不必要だがあってもOK
- あってもなくてもOKなので、よくわからないまま「おまじない」と言われる

この記事を書く際に色々とググっていて目にしたのですが、`.bashrc`や`.zshrc`にシバンを書くべきか否かという論争があるそうです。

答えは「`.bashrc`や`.zshrc`を直接実行させるなら必要」となりますが、そもそもこれらのファイルに実行権限を与えてる例は希少だと思います。念の為に確認してみましたが、私の`.bashrc`と`.zshrc`に実行権限はありませんでした。
実行権限のないファイルにシバンを書く意味はありません[^2]

## まとめ

ファイルに実行権限を与えて、`sh`以外のインタプリタで実行する場合はシバンが必要

以下の用途では必要なし

- `bash foo/bar`とした場合`foo/bar`は`bash`の引数なのでシバン不要
- `python foo/bar`とした場合`foo/bar`は`python`の引数なのでシバン不要
- `/bin/bash`や`/bin/zsh`ではなく`/bin/sh`として実行させる場合はシバン不要

## おまけ

私の環境では`zsh`が２つ入っています。最初から入っている`/bin/zsh`と、後から入れた`/usr/local/bin/zsh`です。環境変数PATHは`/usr/local/bin`が先に読み込まれるようにしているので、単純に`zsh`とすると後者が使われます。

| 実行パス             | バージョン | default |
|:-------------------|:------|:--------|
| /bin/zsh           | 5.3   | ×       |
| /usr/local/bin/zsh | 5.8   | ○       |

バージョン5.8から使える新機能を設定できる`zsh_new`コマンドを作りました。これを呼び出すだけで新機能が設定できる超絶便利なコマンドです😆

```bash
#!/bin/zsh
setopt cd_silent
```

しかし私の環境で実行するとエラーが出ます。`/bin/zsh`はバージョン5.3で`cd_silent`というオプションは実装されていないからです。

`zsh_new`を書き換えるとPATH的に優先されるバージョン5.8で実行されます。

```bash
#!/usr/bin/env zsh
setopt cd_silent
```

このような例があるので、「bashのシバンは`#!/bin/bash`だな」と決め打ちで書くのは悪手かもしれません。`#!/usr/bin/env bash`と書く方が良さそうです[^3]

万が一`/bin`にパスが通ってない場合はコケますけどまさかそんな環境無いですよねぇ...

[^1]: [【エンジニア用語解説】 「完全に理解した」 / Twitter](https://twitter.com/ito_yusaku/status/1042604780718157824)
[^2]: もし間違いがあったらご指摘お願いします！
[^3]: デメリットについては把握できていません。ご存じの方ご指摘お願いします！
