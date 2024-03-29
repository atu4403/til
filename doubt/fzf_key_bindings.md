# シェルでfzfやpecoにキーバインドを設定することに対する疑問

1. fzfやpecoになんでもかんでもキーバインドを設定するのは悪手ではないか
2. 例えばhistory_search関数を呼び出す為なら`his`的なaliasを設定しておけばそんなに手間は変わらない
3. しかしパスを返すような関数は有用
4. fzfでselectしたファイルを`open`するようなら`fo`のようなaliasで十分

## 1. fzfやpecoになんでもかんでもキーバインドを設定するのは悪手ではないか

メリット

- 素早く呼び出せる

デメリット

- 頻繁に使用しない場合キーバインドを忘れてしまう（aliasでも一緒）
- 他に有効利用できる機能に割り当てるためにバインドするキーを空けておいたほうが無難

## 2. 例えばhistory_search関数を呼び出す為なら`his`的なaliasを設定しておけばそんなに手間は変わらない

キーバインドは`ctrl+r`で2アクション、aliasなら`his`+`enter`で4アクション

## 3. しかしパスを返すような関数は有用

例えば`cd`と入力した後でパスを返す関数を呼び出すなら、コマンドラインのその位置にパスが挿入されるのでalliasでは代わりが効かない。`cd`を他のコマンドにする応用が効くので有用

## 4. fzfでselectしたファイルを`open`するようなら`fo`のようなaliasで十分

3で示した「他のコマンド」がopenだとしたら`open {key}`とするのも面倒。この場合`fzf_search_path | open`のようなaliasを作っておけば良いのでやはりキーバインドまで設定してしまうのは助長

## fzfやpecoのキーバインド設定に関するベストプラティクス

- コマンドライン内に選択結果を必要とするならキーバインドを設定
- 結果をそのまま実行するならキーバインドは不要
