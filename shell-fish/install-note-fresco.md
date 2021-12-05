# WIP
<!-- # frescoインストールメモ -->

```bash
> set -U fresco_root (ghq root)

> curl https://raw.githubusercontent.com/masa0x80/fresco/master/install | fish
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100  1503  100  1503    0     0   4301      0 --:--:-- --:--:-- --:--:--  4294
Cloning into '/Users/atu/ghq/github.com/masa0x80/fresco'...
remote: Enumerating objects: 428, done.
remote: Total 428 (delta 0), reused 0 (delta 0), pack-reused 428
Receiving objects: 100% (428/428), 66.85 KiB | 925.00 KiB/s, done.
Resolving deltas: 100% (249/249), done.
Create /Users/atu/.config/fish/conf.d/fresco.fish
Initialize fresco...
  Create /Users/atu/.local/share/fresco/plugins.fish
> exec fish -l
Welcome to fish, the friendly interactive shell
Type help for instructions on how to use fish
```

インストールされたのはファイルは1つと5つの変数

```bash
> cat ~/.config/fish/conf.d/fresco.fish
set -l bootstrap_file /Users/atu/ghq/github.com/masa0x80/fresco/fresco.fish
if test -r $bootstrap_file
    source $bootstrap_file
else
    mkdir -p /Users/atu/ghq/github.com/masa0x80/fresco
    git clone https://github.com/masa0x80/fresco /Users/atu/ghq/github.com/masa0x80/fresco
end
```

```bash
> set | grep -e '^fresco'
fresco_cache /Users/atu/.local/share/fresco/plugin_cache.fish
fresco_log_color brown
fresco_plugin_list_path /Users/atu/.local/share/fresco/plugins.fish
fresco_plugins 'jethrokuan/z'  'decors/fish-ghq'  'PatrickF1/fzf.fish'
fresco_root /Users/atu/ghq
fresco_version 0.5.4
```

`~/.local/share/fresco/`にも2つのファイルを置いているようです。

> これは最初に`set -U fresco_root (ghq root)`としてghq管理ディレクトリを設定しているためだと思います。
> この設定がなかったら`~/.local/share/fresco/`にプラグインのリポジトリも保存するようです。

```bash
> cat $fresco_plugin_list_path
jethrokuan/z
decors/fish-ghq
PatrickF1/fzf.fish
```

## About

- ワンライナーは何をしているのか
- `fisher install`は何をしているのか
- ダウンロードしたリポジトリはどこに置いているのか
- プラグインの関数名が重複したらどうなるのか
- `fisher remove`は何をやっているのか
- `fish_plugins`から直接プラグインを消したらどうなるのか
- 自作プラグインの管理

## ワンライナーは何をしているのか

- `masa0x80/fresco`を`git clone`
- file作成
  - `~/.config/fish/conf.d/fresco.fish`
  - `~/.local/share/fresco/plugins.fish`
  - `~/.local/share/fresco/plugin_cache.fish`
- 変数の作成
  - fresco_cache /Users/atu/.local/share/fresco/plugin_cache.fish
  - fresco_log_color brown
  - fresco_plugin_list_path /Users/atu/.local/share/fresco/plugins.fish
  - fresco_plugins 'jethrokuan/z'  'decors/fish-ghq'  'PatrickF1/fzf.fish'  'je…
  - fresco_version 0.5.4

## `fresco get`は何をしているのか

- リポジトリをclone
- `~/.local/share/fresco/plugin_cache.fish`を作成
- `~/.local/share/fresco/plugins.fish`を編集
- 変数`fresco_plugins`を編集

## ダウンロードしたリポジトリはどこに置いているのか

- defaultでは`~/.local/share/fresco/repos/`
- `set -U fresco_root (ghq root)`でghq管理ディレクトリ

## プラグインの関数名が重複したらどうなるのか

- 読み込み順による？
- インストールしたプラグインは`plugin_cache.fish`から読み込むので、`~/.config/fish/functions`のものは読み込まれない

<!-- TODO: -->
<!-- ## `fisher remove`は何をやっているのか

## `fish_plugins`から直接プラグインを消したらどうなるのか

## 自作プラグインの管理 -->
