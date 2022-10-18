<!-- # macの環境構築-2022/06 -->

macを新調したので環境構築をしていく。

旧マシンは2015年の`mac book pro`を`Mojave(10.14)`で使っていた。OSをupgrade
したいと思いつつ面倒でここまで来てしまった。

折角なので、今の環境を丸ごと引き継ぐのではなく、いらないアプリ等を断舎離して環境構築を行うことにする。

アプリケーションはbrewcaskやmasを使い、設定は手動で行います。(mackupは使わない)

## 方針

旧環境では、cliはzsh,bash,fish等、editorはvim,nano,micro等が混在していた。しかし現在はfishとmicroで落ち着いているのでドットファイルを減らすことができる。(fish,microは共に`.config`以下で管理)

### cli

- fish
- iterm2
- micro

### editor

- vscode

### tool

### cli-tool

- ghq
- fzf
- bat
- exa
- gh
- git
- gibo

## homebrewでアプリケーションを移行

homebrewで旧macにインストールしているアプリケーションをリスト化。これをそのまま新macに移行できます。
ただし手動でインストールしたものは含まれていないので以下のステップで更新していきます。

1. homebrewのリストを作成
2. Applicationsのリストを作成
3. 2を参考に1のリストを修正
4. 新macで1を読み込む

### 1. homebrewのリストを作成

```bash
brew bundle dump --file ~/Brewfile_test
```

生成された`~/Brewfile_test`がこちら。構成がわかるように省略しています。

```bash
tap "homebrew/bundle"
tap "homebrew/cask"
tap "homebrew/cask-fonts"
tap "homebrew/cask-versions"
tap "homebrew/core"
tap "homebrew/services"
tap "mas-cli/tap"
tap "mongodb/brew"
brew "ca-certificates"
brew "ansible"
brew "bat"
brew "boost"
brew "zaquestion/tap/lab"
cask "atom"
cask "db-browser-for-sqlite"
cask "font-fira-code"
cask "vagrant"
cask "virtualbox"
mas "Display Menu", id: 549083868
mas "Evernote", id: 406056744
mas "ForkLift", id: 412448059
```

- brew: cliアプリケーション
- cask: guiアプリケーション
- mas:  mac app storeのアプリケーション

ここから不要なものを除外していきます。1行1アプリケーションなので、不要な行を消すだけです。

このファイルにリスト化されるのはhomebrew経由でインストールしたもの、app atoreでインストールしたもののみです。
インストール済みのアプリのうち、手動でダウンロード→`/Applications`にコピーしてインストールしたものは含まれないので、`/Applications`ディレクトリから一覧を作り、リストに追加していきます。

### 2. Applicationsのリストを作成

```bash
ls -1 /Applications/
```

```bash
Safari.app
Trello.app
TweetDeck.app
Twitter.app
Typora.app
Utilities
# 以下略
```

### 3. 2を参考に1のリストを修正

`Brewfile_test`に含まれないものを追加していきます。
ただし`safari`や`Utilities`等はプリインストールされているので無視して構いません。

アプリケーションがhomebrewでインストール可能か調べるには2つの方法があります。

1. コマンドで調べる
   - `brew search {アプリケーション名}`
2. webで調べる
   - [Homebrew Formulae](https://formulae.brew.sh/)

私の場合旧macがMojave(10.14)だったので1では調べられませんでした。
そんな場合でも、2の方法で最新バージョン等まで調べられます。

```bash
cask "virtualbox"
```

このようにBrewfileを更新していきます。

### 4. 4. 新macで1を読み込む

homebrewをインストールします。

[macOS（またはLinux）用パッケージマネージャー — Homebrew](https://brew.sh/index_ja)

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```


1のファイルを`.Brewfile`に変更してHOMEディレクトリに置きます。`~/.Bruefile`です。


## 設定ファイルの移行

設定を移行したいものをリストアップします。

```bash
Alfred 4.app
Karabiner-Elements.app
PopClip.app
Visual Studio Code.app
```

### Alfred 4

設定を開き`Advanced`→`Set Preferences folder`をクリックして、設定ファイルを保存する場所を指定します。

![alfred](/images/initialize/2022-06-03-14-50-30.png)

この時に`iCloudDrive`を指定すると警告が出ました。
「iCloudとGoogleDriveは信頼できないからDropboxにしといた方が良いよ。それでも使いたいならローカルにバックアップしときな」という感じです。

とはいえiCloudに保存するのが便利そうなのでそうしました。

新macで同じ操作をするとエラーになりました。iCloudDriveなので失敗したようです。適切な場所に(私は`~/.config`以下にしました)配置するとうまく行きました。
しかし clipboardの設定が初期化されてたので再設定。

![alfred clip](/images/initialize/2022-06-04-10-40-31.png)

PowerPackのライセンスキーは過去のメールに書いてありました。「alfred」で検索すると見つかりました。

### karabiner-elements

![karabiner-elements](/images/initialize/2022-06-03-16-44-07.png)

alfredと同じく`~/.config`以下にコピペしました。
設定を開き、`Misc`→`Open Config folder`で指定。

### PopClip

![PopClip](/images/initialize/2022-06-03-16-47-55.png)

設定を開き、手動で確認。必要なものを再インストール。

### git

`~/.gitconfig`を移行

### fish

`~/.config/fish`を移行

## ターミナルからの設定

```bash
# キーリピート設定
defaults write -g KeyRepeat -int 1
defaults write -g InitialKeyRepeat -int 13
# finderでドットファイルを可視化
defaults write com.apple.finder AppleShowAllFiles TRUE
killall Finder
```
