# how to git log case_01

## `foo.md`と一緒にコミットされた過去の有るファイルをリスト化する方法

`foo.md`と`bar.png`を同じコミットに含めていた過去があるとする。

- 1つ前のコミットに含まれるファイル
  - foo.md
- 2つ前のコミットに含まれるファイル
  - foo.md
  - bar.png

この2つのファイルは互いに関係のあるファイルなので一緒に別ブランチから取り込みたいが、cherry-pickするには問題がある。

- 2つ前のコミットをcherry-pickすると`foo.md`の変更が反映しない
- 2つのコミットをまとめて取り込むと`foo.md`がコンフリクトする

なのでcherry-pickではなくrestoreで取り込むことにする。
しかし`foo.md`に関連するファイルが何なのかは過去のコミットを調べないとわからない。

そのような前提の中、`foo.md`と一緒にコミットされた過去の有るファイルをリスト化する方法。

### 1. file foo.mdに関するコミットの抽出

```bash
# hash  7桁
git log --format=%h -- foo.md
# hash 40桁
git log --format=%H -- foo.md
```

### 2. ハッシュ指定でファイル名のみ取り出す

コミットに含まれているfileすべてが出てくる

```bash
# -1を付けないと複数出てくるので注意
git log --name-only --oneline sha1 -1
```

### 3. 1をloopして2で抽出する

fishのscript例

```fish
set -l function_list
for sha in (git log --format=%H -- $argv[1])
    for fname in (git log --name-only --oneline $sha -1)[2..-1]
        if not contains $fname $function_list
            set -a function_list $fname
        end
    end
end
echo $function_list
```
