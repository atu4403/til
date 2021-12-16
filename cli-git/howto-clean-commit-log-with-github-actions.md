# GitHub actionsでCIを行う時にコミットログを汚さない方法

GitHub ActionsをCIとして使う場合、設定のymlファイルの書き間違いでtestが通らないことが多々あります。GitHubにpushしないと失敗がわからないので何度もcommit & pushを繰り返して、コミットログが汚れます。

このような問題に対処する方法をシェアします。

1. localのtestが通る状態で一旦commit
2. 捨てブランチを切ってチェックアウト
3. このブランチで`test.yml`を修正&commit&push
4. CIが通るようになったらmainブランチにチェックアウト
5. git restore
6. commit & push

## 1. localのtestが通る状態で一旦commit

GitHub Actions以外のファイルに一通り目処が付いた段階で一旦commitしてブランチをクリーンにしておきます。

## 2. 捨てブランチを切ってチェックアウト

捨てブランチは後で削除するので名前は何でもいいです。仮に`actions_test`としておきます。

```bash
git checkout -b actions_test
```

## 3. このブランチで`test.yml`を修正 & commit & push

CIの設定ファイルが`.github/workflows/test.yml`とします。
これを思うままに修正、commit、pushを繰り返します。コミットメッセージは適当で良いです。GitHub上でCIが通るまで何回でも繰り返してください。

## 4. CIが通るようになったらmainブランチにチェックアウト

```bash
git checkout main
```

## 5. git restore

`3.`で動くようになったファイルをリストアします。マージするのではなく、動くようになった状態のファイルのみを持ってくるのでコミットは汚れません。

```bash
git restore -s actions_test .github/workflows/test.yml
```

## 6. commit & push

後はmainブランチでcommit & pushするだけです。
remoteとlocalにある`actions_test`ブランチは削除してください。
おつかれさまでした😆
