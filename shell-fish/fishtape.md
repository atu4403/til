# [fishtape](https://github.com/jorgebucaran/fishtape)

fishのテスティングフレームワーク

## install

[fisher](https://github.com/jorgebucaran/fisher)でインストール

```bash
fisher install jorgebucaran/fishtape
```

## 実行

`fishtape ファイル名`でtestを実行。ファイルはワイルドカードで`fishtape tests/*.fish`のような指定も可。

```bash
> fishtape test.fish
TAP version 13
ok 1 a is foo
ok 2 b is bar
ok 3 not a is b

1..3
# pass 3
# ok
```

## テストコード

```bash
set a foo
set b bar

@test 'a is foo' $a = foo
@test 'b is bar' $b = bar
@test 'a is not b' $a != $b
```

`@test`はfishのtestコマンドと同等の動作をする。ただし第１引数はdescriptionになるので適当な説明文を書く。

```bash
@test description [actual] operator expected
```

一時的ディレクトリを作ってその中でファイル作成やgitの操作をテストを行う例

```bash
set temp (mktemp -d)

cd $temp

@test "a regular file" (touch file) -f file
@test "nothing to see here" -z (read < file)

git init
git add --all && git commit -m 'first commit'

@test "repo is clean" (git diff-index --quiet @) $status -eq 0

rm -rf $temp
```
