# Awasome Extentions - VScode

VScodeのオススメ機能拡張です。2021年12月版。

- 100万回以上ダウンロードされてる有名どころは除外してます
- ☁️で始まる数字は2021年12月1日時点でのダウンロード数

## [Bracket Select - Visual Studio Marketplace](https://marketplace.visualstudio.com/items?itemName=chunsen.bracket-select)

☁️ 36,075

括弧やクォーテーション内のテキストをショートカット一発で選択。括弧を含む含まないどっちも可能。マルチセレクトにも対応。

![alt](https://github.com/wangchunsen/vscode-bracket-select/raw/master/bracket-select.gif)

## [Conventional Commits - Visual Studio Marketplace](https://marketplace.visualstudio.com/items?itemName=vivaxy.vscode-conventional-commits)

☁️ 50,294

gitのコミットメッセージ規約である[Conventional Commits](https://www.conventionalcommits.org/ja/v1.0.0/)に従ったコミットメッセージを作成補助するツール。

![alt](https://github.com/vivaxy/vscode-conventional-commits/raw/master/assets/docs/demo.gif)

## [Fish - Visual Studio Marketplace](https://marketplace.visualstudio.com/items?itemName=bmalehorn.vscode-fish)

☁️ 13,763

fish scriptのコードハイライト、lint, formatに対応。別の機能拡張のほうが人気だがこっちのほうが高機能。

## [Incrementor - Visual Studio Marketplace](https://marketplace.visualstudio.com/items?itemName=nmsmith89.incrementor)

☁️ 31,515

数字が書いてある場所でショートカットキーを押すとインクリメント、デクリメントできる。

![alt](https://github.com/nmsmith22389/vscode-incrementor/raw/master/images/by-tenth.gif)

defaultのキー設定。

```json
{
    "command": "incrementor.incrementByOne",
    "key": "ctrl+up"
},
{
    "command": "incrementor.decrementByOne",
    "key": "ctrl+down"
},
{
    "command": "incrementor.incrementByTenth",
    "key": "ctrl+shift+alt+up"
},
{
    "command": "incrementor.decrementByTenth",
    "key": "ctrl+shift+alt+down"
},
{
    "command": "incrementor.incrementByTen",
    "key": "ctrl+shift+up"
},
{
    "command": "incrementor.decrementByTen",
    "key": "ctrl+shift+down"
}
```

## [Insert Date String - Visual Studio Marketplace](https://marketplace.visualstudio.com/items?itemName=jsynowiec.vscode-insertdatestring)

☁️ 51,336

ショートカットキーで日付を挿入できる。

- Insert DateTime (⇧+⌘+I on OS X, Ctrl+Shift+I on Windows and Linux) - Inserts current date and/or time according to configured format (format) at the cursor position.
- Insert Date - Inserts current date according to configured format (formatDate) at the cursor position.
- Insert Time - Inserts current time according to configured format (formatTime) at the cursor position.
- Insert Timestamp - Inserts current timestamp in milliseconds at the cursor position.
- Insert Formatted DateTime (⇧+⌘+⌥+I on OS X, Ctrl+Alt+Shift+I on Windows and Linux) - Prompt user for format and insert formatted date and/or time at the cursor position.

## [Markdown Table Maker - Visual Studio Marketplace](https://marketplace.visualstudio.com/items?itemName=hellorusk.markdown-table-maker)

☁️ 1,130

markdownの表をカンタンに作成。

![alt](https://user-images.githubusercontent.com/36184621/56092677-e6967b00-5ef9-11e9-8487-96bd057549df.gif)

使い方は製作者さんのqiitaを参照。

> [Markdown のテーブルを直感的に生成できる VSCode の拡張機能を作った - Qiita](https://qiita.com/HelloRusk/items/d044e64918fa9bd4c92a)

## [Markdown Table Prettifier - Visual Studio Marketplace](https://marketplace.visualstudio.com/items?itemName=darkriszty.markdown-table-prettify)

☁️ 99,705

markdownの表をカンタンに整形。設定の`format on save`を有効化していれば保存時に整形してくれる。

![Markdown Table Prettifier - Visual Studio Marketplace](https://github.com/darkriszty/MarkdownTablePrettify-VSCodeExt/raw/HEAD/assets/animation.gif)

## [Paste Image - Visual Studio Marketplace](https://marketplace.visualstudio.com/items?itemName=mushan.vscode-paste-image)

クリップボード内の画像を保存してmarkdownの画像リンクを生成してくれる。神ツール。

☁️ 145,515

![alt](https://raw.githubusercontent.com/mushanshitiancai/vscode-paste-image/master/res/vscode-paste-image.gif)
