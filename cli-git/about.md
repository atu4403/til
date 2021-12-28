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

## git statusがcleanか確認する方法(fish)

```bash
# git管理内か確認
git rev-parse --is-inside-work-tree
# gitがdirtyでないなら出力なし
# string lengthは文字数が1以上ならtrueなので反転させる
git status --short | string length
```

string lengthがちょっとややこしい。

| 文字数 | 終了ステータス |
|:-------|:----------|
| 1以上  | 0         |
| 0      | 1以上     |

```bash
function git_is_clean
    if git rev-parse --is-inside-work-tree >/dev/null 2>&1
        if ! git status --short | string length >/dev/null 2>&1
            return 0
        end
    end
    return 1
end
```

## git logでコミットに紐付いた更新ファイルを見る方法

```bash
git log --name-only --oneline
```
