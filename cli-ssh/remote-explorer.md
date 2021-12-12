# vscode-remote-explorer

vscode左のアイコンからリモートエクスプローラーを選択し、SSH Targetを選ぶと`.ssh`の設定からhost一覧が表示される。

![alt](/images/remote-explorer/2021-12-12-18-43-13.png)

host名をクリックすると別Windowが開いて接続される。

## Docker ps

ターミナルでdocker psすると起動中コンテナの確認ができるが、docker機能拡張で表示されるものの方が見やすい。

![alt](/images/remote-explorer/2021-12-12-18-48-45.png)

使用中のportを確認する方法

```bash
> docker ps --format "table {{.Ports}}" 
PORTS
0.0.0.0:8081->8081/tcp, :::8081->8081/tcp
0.0.0.0:6378->6379/tcp, :::6378->6379/tcp
0.0.0.0:8080->8080/tcp, :::8080->8080/tcp
0.0.0.0:3306->3306/tcp, :::3306->3306/tcp, 33060/tcp
```

## explorer

エクスプローラーも普通に使えるのでローカルと同じように操作できる。なのでローカルでファイルを作成してscp等でリモートにコピーするよりも、直接リモートでファイルの作成、編集した方が楽。

![alt](/images/remote-explorer/2021-12-12-18-54-00.png)

## example

リモートのdockerにmongodbを建てる例
`docker-mongodb`ディレクトリを作成し、`docker-compose.yml`に以下の記述

```bash
# Use root/example as user/password credentials
version: '3.1'

services:

  mongo:
    image: mongo
    restart: always
    environment:
      MONGO_INITDB_ROOT_USERNAME: root
      MONGO_INITDB_ROOT_PASSWORD: example
    ports:
      - 27017:27017
    volumes:
      - ./db:/data/db
      - ./configdb:/data/configdb
```

[docker-composeでmongoDB環境を構築して使う - Qiita](https://qiita.com/mistolteen/items/ce38db7981cc2fe7821a)

mongo-expressは不要なので削除。
volumesのディレクトリは自動作成されるので自分で用意するのは`docker-compose.yml`だけでOK

ターミナルから`docker-compose.yml`があるディレクトリに移動して`docker-compose up -d`で起動(-dはバックグラウンドで起動させるために必要)

ローカルから接続。`mongo`は非推奨で`mongosh`使えって言われた。`brew list`で確認したら入ってた。

```bash
mongosh --host 192.168.0.xxx
Current Mongosh Log ID: 61b5d7ff9d9f3338c16e717b
Connecting to: mongodb://192.168.0.xxx:27017/?directConnection=true
Using MongoDB: 5.0.5
Using Mongosh: 1.0.5

For mongosh info see: https://docs.mongodb.com/mongodb-shell/


To help improve our products, anonymous usage data is collected and sent to MongoDB periodically (https://www.mongodb.com/legal/privacy-policy).
You can opt-out by running the disableTelemetry() command.

Warning: Found ~/.mongorc.js, but not ~/.mongoshrc.js. ~/.mongorc.js will not be loaded.
  You may want to copy or rename ~/.mongorc.js to ~/.mongoshrc.js.
```

[MongoDBコンパスを使用してユーザーを参照/セットアップ?- スタックオーバーフロー](https://stackoverflow.com/questions/46972695/see-setup-a-user-with-mongodb-compass)
