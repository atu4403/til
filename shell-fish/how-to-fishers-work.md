# fisherは何をしているのか

## 環境

- fish   3.3.1
- fisher 4.3.0

## About

- ワンライナーは何をしているのか
- `fisher install`は何をしているのか
- ダウンロードしたリポジトリはどこに置いているのか
- プラグインの関数名が重複したらどうなるのか
- `fisher remove`は何をやっているのか
- `fish_plugins`から直接プラグインを消したらどうなるのか
- 自作プラグインの管理

## ワンライナーは何をしているのか

fisherのインストールはコマンドラインに1行打ち込むだけ。これが何をしているのか解説。

```bash
curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
```

`&&`の前後で２つの処理が行われている。まず前半部分で`https://git.io/fisher`で取得したものを`source`に渡している。

`https://git.io/fisher`は短縮urlになっているが、fisherリポジトリの`functions/fisher.fish`にリンクしている。

[fisher/fisher.fish at main · jorgebucaran/fisher](https://github.com/jorgebucaran/fisher/blob/main/functions/fisher.fish)

ここでは`fisher`という名のfish関数が定義されており、`source`に渡すことで関数を呼び出せるようにしている。

しかしこのままではシェルを閉じたら関数は使えなくなってしまうので、後半部分の`fisher install jorgebucaran/fisher`により自信をインストールしている。

## `fisher install`は何をしているのか

ワンライナーを実行した際の出力。curlは`-s`により出力が無いので実質的に`fisher install`部分のログになる。

```bash
> curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
fisher install version 4.3.0
Fetching https://codeload.github.com/jorgebucaran/fisher/tar.gz/HEAD
Installing jorgebucaran/fisher
           /Users/atu/.config/fish/functions/fisher.fish
           /Users/atu/.config/fish/completions/fisher.fish
```

`fisher install`は以下のことを行う。

1. `https://codeload.github.com`からリポジトリのHEADをダウンロード
2. `functions/fisher.fish`と`completions/fisher.fish`を`~/.config/fish`に設置
3. `~/.config/fish/fish_plugins`というファイルに情報を追加
4. 変数`$_fisher_plugins`を更新
5. 変数`$_fisher_jorgebucaran_2F_fisher_files`を作成

`~/.config/fish/fish_plugins`と変数`$_fisher_plugins`は同じ内容

```bash
jorgebucaran/fisher
```

変数`$_fisher_jorgebucaran_2F_fisher_files`には設置したファイルの情報

```bash
/Users/atu/.config/fish/functions/fisher.fish
/Users/atu/.config/fish/completions/fisher.fish
```

また、`1`でダウンロードしたものは`.git`ディレクトリを含めたリポジトリではなく、`HEAD`（つまり最新）のファイルのみ。しかも`tar.gz`の圧縮アーカイブなので`git clone`するのと比べてサイズがかなり小さくなる。

`2`の設置は、`1`でダウンロードしたものの`{completions,conf.d,functions}`の各ディレクトリに含まれているものを`~/.config/fish/`の同名ディレクトリにコピーしている。

## ダウンロードしたリポジトリはどこに置いているのか

ソースコードを見ると一時的な使い捨てのディレクトリにダウンロードして、処理が終われば廃棄している。

[fisher.fish#L73](https://github.com/jorgebucaran/fisher/blob/main/functions/fisher.fish#L73)

`mktemp -d`はtemp_directoryの作成、`rm -rf`で廃棄。

## プラグインの関数名が重複したらどうなるのか

例えば[oh-my-fish/theme-bobthefish](https://github.com/oh-my-fish/theme-bobthefish)は別のプラグインマネージャである`oh-my-fish`のプラグインなので、`fisher`で管理するものではない。しかしGitHubでファイル構成を見てみると`functions`ディレクトリに`.fish`ファイルが並んでいるだけなのでおそらく`fisher`でインストールできるはず。

```bash
> fisher install oh-my-fish/theme-bobthefish
fisher install version 4.3.0
Fetching https://codeload.github.com/oh-my-fish/theme-bobthefish/tar.gz/HEAD
fisher: Cannot install "oh-my-fish/theme-bobthefish": please remove or move conflicting files first:
        /Users/atu/.config/fish/functions/fish_prompt.fish
        /Users/atu/.config/fish/functions/fish_right_prompt.fish
```

しかし失敗した。`fish_prompt`と`fish_right_prompt`が既に存在するので、これを先に削除してねという警告。

`fish_prompt`と`fish_right_prompt`は、`fish_config`コマンドによりブラウザでプロンプトを設定したら自動で作られる。

つまり`fisher`は既存のファイルを上書きすることのない安全設計だということ。

## `fisher remove`は何をやっているのか

単純に考えたらinstallの逆なので、対象リポジトリの`{completions,conf.d,functions}`ディレクトリに含まれるファイルが`~/.config/fish/`の同名ディレクトリに存在するなら削除されるような気がする。

fisherでインストール**していない**`oh-my-fish/theme-bobthefish`をremoveしたら、すでに存在する同名の関数`fish_prompt`と`fish_right_prompt`が削除されるのか実験。

```bash
> fisher remove oh-my-fish/theme-bobthefish
fisher: Plugin not installed: "oh-my-fish/theme-bobthefish"
```

できなかった。
つまり`fisher remove`は`fish_plugins`に書いてるものに限る。

## `fish_plugins`から直接プラグインを消したらどうなるのか

`fish_plugins`を直接編集して`fisher update`すれば反映するのは公式READMEにも書かれている。

[jorgebucaran/fisher: A plugin manager for Fish.](https://github.com/jorgebucaran/fisher#using-your-fish_plugins-file)

```diff
jorgebucaran/fisher
ilancosman/tide
jorgebucaran/nvm.fish@2.1.0
+ PatrickF1/fzf.fish
- /home/jb/path/to/plugin
```

```console
fisher update
```

これにより **PatrickF1**/**fzf.fish**は新たにインストールされて/**home**/**jb**/**path**/**to**/**plugin**は削除される。

しかし`fish_plugins`から「消した」のか「最初から無かった」のかどうやって判断しているのかという疑問が湧いた。が、すぐ解消した。

`fisher install`の作業で、変数にもプラグインの情報を保持しているのを思い出した。

つまり「消した」のなら変数に情報が存在し、「最初から無かった」なら変数に情報は無い。

このように、変数とファイルの両方によりプラグインの管理をしている。

## 自作プラグインの管理

自作でプラグインを作るなら`~/.config/fish/`とは別の場所で管理したい。しかしこれをfishに反映させるには`~/.config/fish/`の中にファイルをコピーして再読み込みするか、もしくは`source`で読み込む必要がある。

`fisher`はGitHubリポジトリに限らずローカルのディレクトリもプラグインとして管理できる。

```bash
# インストール
fisher install /path/to/my_pulugins
# 更新
fisher update /path/to/my_pulugins
```

updateをaliasやabbrに登録しておけば簡単なコマンドで自作でプラグインを認識してくれるようになる。

## まとめ

### メリット

- コマンド一発で簡単にインストール
- ローカルの自作プラグインも管理できる
- リポジトリを保存しないのでストレージに優しい
- 重複を許可しない安全設計

### デメリット

- `~/.config/fish/`にファイルを置くので自作との区別がしにくい
- プラグイン同士でキーバインドが重複する可能性がある

なお、後者はプラグインを使うことに対する問題であり`fisher`のデメリットではない。
