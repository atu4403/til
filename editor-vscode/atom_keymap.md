# vscodeのatom-keymapをやめる

[Atom Keymap - Visual Studio Marketplace](https://marketplace.visualstudio.com/items?itemName=ms-vscode.atom-keybindings)

思えばvscode使って長くなる。最初はatomから移行したのでatomのkeymapを流用できる拡張を入れて、そのまま今に至る。
そもそもatomのkeymapで使ってるものがどれだけあるのか調べてみた。

| Command                                    | atom               | vscode           |
|:-------------------------------------------|:-------------------|:-----------------|
| `editor.action.moveLinesDownAction`        | `ctrl+cmd+down`    | `alt+down`       |
| `editor.action.moveLinesUpAction`          | `ctrl+cmd+up`      | `alt+up`         |
| `editor.action.copyLinesDownAction`        | `cmd+shift+d`      | `shift+alt+down` |
| `editor.action.deleteLines`                | `ctrl+shift+k`     | `cmd+shift+k`    |
| `filesExplorer.copy`                       | `cmd+c`            | =                |
| `moveFileToTrash`                          | `backspace`        | `cmd+backspace`  |
| `workbench.action.toggleZenMode`           | `cmd+shift+ctrl+f` | `cmd+k z`        |
| `workbench.action.toggleSidebarVisibility` | `cmd+\`            | `cmd+b`          |
| `workbench.action.quickOpen`               | `cmd+t`            | `cmd+p`          |
| `workbench.action.terminal.toggleTerminal` | `ctrl+alt+t`       | 'ctrl+\`'  |
| `workbench.action.openGlobalSettings`      | `cmd+,`            | =      |

行コピーと行削除くらいであとはあまり使っていない。ということでatom keymapは削除することにした。

## よく使うkey

|   | key | title                 | command                 |
|:--|:----|:----------------------|:------------------------|
| c | ⇧⌃f | エクスプローラ切替           | workbench.view.explorer |
|   | ⇧⌃g | ソースコントロール切替         | workbench.view.scm      |
| c | ⇧⌃d | 表示: 実行とデバッグ を表示 | workbench.view.debug    |
|| ⌃` | 表示: ターミナル の切り替え    |workbench.action.terminal.toggleTerminal|
|| ⌘ b | サイドバーのトグル          |workbench.action.toggleSidebarVisibility|
|| ⌥⌘a | brasel: 括弧選択   |bracket-select.select|
|| ⌥a  | brasel: 括弧内選択 |bracket-select.select-include|
|| ⌥z  | brasel: 選択解除   |bracket-select.undo-select|
|| ⇧⌘d | 行を複製            |editor.action.copyLinesDownAction|
|| ⇧⌘k | 行を削除            |editor.action.deleteLines|
|| ⇧⌘p | すべてのコマンドの表示            |workbench.action.showCommands|
|| ⌘p | ファイルに移動...            |workbench.action.quickOpen|

keybindが設定されていないvscode insidersで最初から設定してみた。

- 行コピーの`⇧⌘d`を押したらデバッグコントロールの表示になる。これを削除したら使えるようになった。(なぜか同じキーが最初から割り当てられている)
- ソースコントロール切り替えは`⇧⌃g`だが、隣の`⇧⌃f`と`⇧⌃d`が空いてた。これをそのままサイドバー切り替え関係に設定した
- 結局、2つ変更しただけで慣れたキーバインドになった
