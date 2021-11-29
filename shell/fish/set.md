# set (fish 3.3.1)

`set`は変数定義のコマンド。

構文は`set [OPTIONS] VARIABLE_NAME VALUES...`

※ scopeについては触れていません。公式を見てください。

[set - display and change shell variables — fish-shell 3.3.1 documentation](https://fishshell.com/docs/current/cmds/set.html?highlight=set)

```bash
> set a a b c
> echo $a
a b c
> count $a
3
> set a x y
> count $a
2
> set a[2] f
> echo $a
x f
> set -a a b c
> echo $a
x f b c
```

fishの変数は全て配列である。`count`は配列の長さを出力する。

```bash
# クォートなしの場合、スペース区切りの別要素と判定される
> set val a b c
> count $val
3
# クォートで囲めば一つの要素となる
> set val "a b c"
> count $val
1
```

配列なのでindexで値を出し入れできる。indexは`1`始まりなので注意。

`[-1]`で最後の要素を示せる。`[999]`のように配列外の数値を示すとエラーが出ず無視される。戻り値はなし

```bash
> set val a b c
> set val[1] x
> echo $val
x b c
> echo $val[-1]
c
> echo $val[999]

```

`-a` `--append`オプションで追加。

```bash
> set val a b c
> set -a val x y z
> echo $val
a b c x y z
```

## 変数の展開

変数を他の関数に渡す場合、３つの方法がある。仮に変数`val`が`[a b c]`だった場合

- set val a b c
  - 変数`val`は`[a b c]`
- fn $val
  - `fn a b c`と同義
- fn "$val"
  - `fn "a b c"`と同義
- fn '$val'
  - `fn '$val'`と同義

```bash
> set -a a x y z
> echo $a
x y z
# 変数を引用符で囲まない例
> set b $a
> echo $b
x y z
> count $b
3
> echo $b[1]
x

# 変数をダブルクオーテーションで囲む例
> set c "$a"
> echo $c
x y z
> count $c
1
> echo $c[1]
x y z
```

上記の`set b $a`は`set b x y z`と同義になる。配列である`$a`をスペースでsplitして変数として展開したことになる。

set関数は引数全てが配列に入るので問題は無いが以下のケースでは不具合が生じる

- $val = [a b c]
- 関数xが求める引数
  - 第1引数: 文字列型
  - 第2引数: 数値型
- x $val 99 とした場合
  - 第1引数: a
  - 第2引数: b
- x "$val" 99 とした場合
  - 第1引数: a b c
  - 第2引数: 99
- x '$val' 99 とした場合
  - 第1引数: $val
  - 第2引数: 99
