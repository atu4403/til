# Awasome Extentions - VScode (2022)

VScodeのオススメ機能拡張です。2022年11月版。

## [Snippet Generator](https://marketplace.visualstudio.com/items?itemName=fiore57.snippet-generator)

☁️ 3,785

[VSCode で簡単にスニペットを追加できる拡張機能 | PCの歯車](https://www.pc-gear.com/post/vscode-snippet-generator/)

![alt](https://github.com/fiore57/snippet-generator/raw/master/snippet-generator.gif)

登録するコードの例。

```python
@pytest.fixture
def ${1:fixture_name}(${2:args}):
    ${3:pass}
```

`${1:fixture_name}`のように囲んだ部分は、スニペットを呼び出した時にフォーカスが当たって順に入力できるようになる。

スニペット化したいコード部分を選択して右クリックし「スニペットを作成」すると対話式で登録できる。

編集機能はないので下記の拡張を別に入れると便利。

## [Easy Snippet - Visual Studio Marketplace](https://marketplace.visualstudio.com/items?itemName=inu1255.easy-snippet)

☁️ 73,857

スニペットの一覧を表示、編集、削除する。

![alt](https://github.com/inu1255/vscode-easy-snippet/raw/master/media/screenshot.gif)

サイドバーに`”`のようなアイコンから開き、登録済みのスニペットを一覧できる。

選択するとスニペットがエディタで開くので、そのまま編集可能。saveして閉じたら完了。
