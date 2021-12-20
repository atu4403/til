# about fish

## 変数

fishの変数はリスト(配列)です。

```bash
set val a b c
```

変数valは`[a, b, c]`（要素数3）になります。

```bash
set val 'a b c'
```

変数valは`['a b c']`（要素数1）になります。

```bash
set val a b c
set val d e f $val
```

変数valは`[d, e, f, a, b, c]`（要素数6）になります。

## 環境変数

### 1. config.fishに書くパターン

```bash
set -x PATH /bin $PATH
set -x PATH /usr/bin $PATH
```

### 2. ユニバーサル変数としてターミナルから設定するパターン

```bash
set -Ux FZF_DEFAULT_OPTS "--pointer 👻"
```

### 注意

config.fishでユニバーサル変数をsetしちゃダメ

```bash
set -Ux PATH /bin $PATH
```

config.fishに上記のような書き方をするとユニバーサル変数である`PATH` に`/bin`が追加されます。ユニバーサル変数は永続化するので、config.fishを読み込むたびにPATHは`[/bin /bin /bin]`と同じ要素を追加していきます。
`set -x PATH`なら空の変数PATHに追加するので問題なしです。

## その他

- helpコマンドでブラウザにヘルプが表示されるが、web上のものではなくlocalのファイルである(urlを確認)
