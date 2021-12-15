# mongodbで新規ユーザ作成

mongodbで新規ユーザ作成をする方法。

## 環境

- mongoDB: 5.0.5
- mongosh: 1.0.5

mongoコマンドを使うと「mongoは非推奨だからmongosh使ってね」と警告が出るので`mongosh`を使う。

```bash
================
Warning: the "mongo" shell has been superseded by "mongosh",
which delivers improved usability and compatibility.The "mongo" shell has been deprecated and will be removed in
an upcoming release.
We recommend you begin using "mongosh".
For installation instructions, see
https://docs.mongodb.com/mongodb-shell/install/
================
```

[MongoDB Shell (mongosh) — MongoDB Shell](https://docs.mongodb.com/mongodb-shell/)

## jsファイルの作成

シェル内でポチポチ打つのは面倒なので別ファイルを読み込む形で実行する。
mongoshは`javascript`を読み込めるのでjsで書く。文法はシェルに直接打ち込むのとほぼ変わらないが`use admin`のような文法はエラーになるので注意。

`mongouser.js`というファイルを作成した。ファイル名は何でもいい。

```bash
(function () {
  db.auth('root', 'example');
  db.createUser({
    user: 'testuser2',
    pwd: 'testpass2',
    roles: [{role: 'readWrite', db: 'test_db2'}],
  });
})();
```

ポイント

- 即時実行関数として書く
- adminへのアクセスとユーザ作成権限のあるユーザで認証する
  - `db.auth('root', 'example')`の部分
  - セキュリティ的にはこのようなユーザ名&パスワードは絶対ダメ
- roleは適切に設定する必要があるが、読み書きだけなら`readWrite`でOK
  - [Built-In Roles — MongoDB Manual](https://docs.mongodb.com/manual/reference/built-in-roles/)

## 実行

- mongoshで実行
- ユーザ情報はadminデータベースで一元管理するのが良いので`admin`を明示する
- `-f`で読み込むファイルを指定

```bash
mongosh "mongodb://192.168.0.99/admin" -f mongouser.js
```

mongoが`localhost`にあるなら`mongodb://localhost/admin`もしくは`admin`だけでも良いはず（未確認）

ログにエラーが出ていなければユーザ作成ができているはずなので、実際にログインして確認。

```bash
> mongosh --username testuser2 --host 192.168.0.99 --authenticationDatabase admin -p
Enter password: ****
Current Mongosh Log ID: 61b93f4241775e3399b19957
Connecting to:    mongodb://192.168.0.99:27017/?directConnection=true
MongoServerError: Authentication failed.
```

パスワードの入力を求められるので先程の`testpass2`を入力する。エラーが出ないならユーザ作成は成功している。上記のログはパスワードを間違えた例。

## その他

pymongoでは以下のように接続する。`authSource`を指定しない場合はdefaultの`admin`にて認証が行われる。

```bash
MongoClient('mongodb://testuser2:testpass2@192.168.0.99')
```

## まとめ

1. jsファイルを作成
2. ターミナルで実行

```bash
(function () {
  db.auth('root', 'example');
  db.createUser({
    user: 'testuser2',
    pwd: 'testpass2',
    roles: [{role: 'readWrite', db: 'test_db2'}],
  });
})();
```

```bash
mongosh "mongodb://192.168.0.99/admin" -f mongouser.js
```
