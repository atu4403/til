# git log

## file `foo.md`に関するコミットのhashを抽出

```bash
# hash  7桁
git log --format=%h -- foo.md
# hash 40桁
git log --format=%H -- foo.md
```

## ハッシュ指定でファイル名のみ取り出す

コミットに含まれているfileすべてが出てくる

```bash
# -1を付けないと複数出てくるので注意
git log --name-only --oneline sha1 -1
```
