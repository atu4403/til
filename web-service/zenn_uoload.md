# zennに記事をアップロードする方法

> tilに書いた記事を[atu4403/zenn-hub](https://github.com/atu4403/zenn-hub)に移植する方法であり、一般的な手法ではないので注意。

## 1. ファイルの作成

`atu4403/zenn-hub/articles`以下に`.md`のファイルを作成する。
ファイル名は被らないかつわかりやすい名前にする(howto_,python_fire_等のプレフィックスを付ける)

## 2. 記事のコピー

1のファイルに記事をコピペする

## 3. フロントマターを付ける

mdファイルにフロントマターを付ける。

```bash
---
title: "nodejs気軽にバージョンアップできない説"
emoji: "📑"
type: "tech" # tech: 技術記事 / idea: アイデア
topics: ['Nodejs']
published: true
---
```

publishedをfalseにすると非公開にもできる。

## 4. 確認

ターミナルから`npx zenn preview`でローカルサーバーを立ち上げて確認できる。

## 5. アップロード

`git commit`してpushすればアップ完了。
