# git about

gitに関する断片的な知見

## commit -a

- `commit -a`は`add`と`commit`を一緒にできる
- なら`git add --all && git commit -m 'first commit'`は助長
- `git commit -am 'first commit'`で一発じゃん！
- しかし`commit -a`はトラッキングされていない新規ファイルはaddされないので↑はできない

## 現在のブランチ名を取得する

```bash
git branch --show-current
```
