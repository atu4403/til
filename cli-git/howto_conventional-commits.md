# WIP

[Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/)

## v0の意味

メジャーバージョンが`0`は開発版を意味します。開発中は仕様が固まっておらず、機能の追加や廃止（破壊的変更）が頻発するものと捉えられます。
ユーザーは、バージョン0のものは「昨日使えてた機能が使えなくなる」と解釈するので、仕様が固まったらメジャーバージョンを1にしてreleaseすべきです。

## コミットの粒度

コミットメッセージに合わせたコミットを行う。

例えば新機能追加のコーディングをしている時にバグが見つかった。バグを修正して新機能も完成した。

```python
def aaa():
-   return 1
+   return 0

+ def bbb()
+     return aaa() + 1
```

これを１度にコミットしてしまうとConventional Commitsの`feat`と`fix`が混在してしまう。

- fix: aaaを修正
- feat: bbbを追加

このように2つのコミットに分ける。

同じファイルのコミットを行ごとで分けるには`git add --interactive`や`git add --patch`で行うことができる。

[Git - 対話的なステージング](https://git-scm.com/book/ja/v2/Git-%E3%81%AE%E3%81%95%E3%81%BE%E3%81%96%E3%81%BE%E3%81%AA%E3%83%84%E3%83%BC%E3%83%AB-%E5%AF%BE%E8%A9%B1%E7%9A%84%E3%81%AA%E3%82%B9%E3%83%86%E3%83%BC%E3%82%B8%E3%83%B3%E3%82%B0)

しかし直感的にわかりにくいので`gitup`を使う方法がオススメ。

[GitUp](https://gitup.co/)
