# fish - plugins

## jorgebucaran/fisher

fishプラグインマネージャ

インストールに必要なリポジトリをディスクに保存せず必要な関数だけを抜き出して保存するので、ディスク容量に優しい設計。

しかし本来はユーザーの領域である`~/.config/fish/`に関数を置くので、自作関数との区別がつきにくくなってしまう。

[別記事](how-to-fishers-work.md)

## [masa0x80/fresco](https://github.com/masa0x80/fresco)

fishプラグインマネージャ

リポジトリをディスクにcloneするので必要なディスク容量が大きくなってしまう。しかし考え方を変えればソースにアクセスするのが容易なのでカスタマイズしやすい。

frescoを使う上で`~/.config/fish/`には`conf.d/fresco.fish`の1ファイルだけしか置かないので、fisherと違い自作関数を管理しやすい。

## jethrokuan/z

ディレクトリ移動補助

## decors/fish-ghq

[decors/fish-ghq: ghq completion and keybinding for fish shell](https://github.com/decors/fish-ghq)

ghqの補完、 fzf, fzy, peco, percol or skimを利用したディレクトリ移動

ショートカットキー`ctrl-g`で発火。並んだリポジトリを選択すればそのディレクトリまで移動する

## jorgebucaran/fishtape

[fishtape](https://github.com/jorgebucaran/fishtape)

fishのテスティングフレームワーク

[別記事](fishtape.md)

## [PatrickF1/fzf.fish](https://github.com/PatrickF1/fzf.fish)

fzfの色々な便利関数+キーバインド

`fd`や`bat`がインストールされていることを前提とするが、そのおかげでファイル一覧やプレビューがハイライトされてて見やすい。

![sile paths](https://github.com/PatrickF1/fzf.fish/raw/main/images/directory.gif)

`ctrl + v`による変数検索が地味に便利。

## TODO

- [oh-my-fish/plugin-osx: Integration with Finder and iTunes.](https://github.com/oh-my-fish/plugin-osx)
- [oh-my-fish/plugin-pj: The Project Jump plugin for the fish shell](https://github.com/oh-my-fish/plugin-pj)
