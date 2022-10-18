# CheatSheet

このチートシートはatu4403の個人的なものです。独自の設定をしている場合があるので動作は保証しません。

## lt le gt ge

|    |    |                          |
|:---|:---|:-------------------------|
| =  | eq | equal to                 |
| != | ne | not equal to             |
| <  | lt | less than                |
| <= | le | less than or equal to    |
| >  | gt | greater than             |
| >= | ge | greater than or equal to |

## shortcuts

- ⌘ - cmd
- ⇧ - shift
- ⌃ - ctrl
- ⌥ - opt

### [fzf.fish](https://github.com/PatrickF1/fzf.fish)

FEATURE           | MNEMONIC KEY SEQUENCE       | CORRESPONDING OPTION
:-----------------|:----------------------------|:--------------------
Search directory  | Ctrl+Alt+F (F for file)     | --directory
Search git log    | Ctrl+Alt+L (L for log)      | --git_log
Search git status | Ctrl+Alt+S (S for status)   | --git_status
Search history    | Ctrl+R     (R for reverse)  | --history
Search variables  | Ctrl+V     (V for variable) | --variables

### [jethrokuan/fzf: Ef-🐟-ient fish keybindings for fzf](https://github.com/jethrokuan/fzf)

| Legacy      | New Keybindings | Remarks                            |
|-------------|-----------------|------------------------------------|
| Ctrl-t      | Ctrl-o          | file or directoryを探してコマンドラインに表示 |
| Ctrl-r      | Ctrl-r          | Search through command history.    |
| Alt-c       | Alt-c           | 再帰的にcd                          |
| Alt-Shift-c | Alt-Shift-c     | 再帰的にcd (隠しファイルも含む)            |
| Ctrl-o      | Alt-o           | $EDITORで開く                        |
| Ctrl-g      | Alt-Shift-o     | open commandで開く                   |

### vscode

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

[Bracket Select - Visual Studio Marketplace](https://marketplace.visualstudio.com/items?itemName=chunsen.bracket-select)

### [Karabiner-Elements 設定項目](https://gist.github.com/atu4403/683f580f8464a0b9f8eefd1e13300604)

Hyper: capslock

|         |                   |
|:--------|:------------------|
| Hyper+i | ↑                 |
| Hyperj  | ←                 |
| Hyper+k | ↓                 |
| Hyper+l | →                 |
| Hyper+n | カーソルの左を全消し     |
| Hyper+m | delete            |
| Hyper+M | カーソルの左を全消し     |
| Hyper+, | カーソルの右を１文字消去 |

### fish

[shortcut-fish](shortcut/fish.md)より使いそうなものを抜粋

|            |                  |
|:-----------|:-----------------|
| ⌃x         | 行をコピー           |
| ⇧tab       | 補完と検索        |
| ⇧←         | ブロック単位で左に移動 |
| ⇧→         | ブロック単位で右に移動 |
| ⌥←         | 単語単位で左に移動 |
| ⌥→         | 単語単位で右に移動 |
| ⌥b         | 単語単位で左に移動 |
| ⌥f         | 単語単位で右に移動 |
| ⌃u         | カーソルより左を消去    |
| ⌃k         | カーソルより右を消去    |
| ⌃w         | パスの区切りまで消去   |
| ⌥h or F1   | manを表示         |
| ⌃z         | undo             |
| ⌥/         | redo             |
| ⌥backspace | 単語単位で削除    |

### fzf(絞り込み)

| Token     | Match type                 | Description       |
|-----------|----------------------------|-------------------|
| `sbtrkt`  | fuzzy-match                | `sbtrkt`であいまい検索 |
| `'wild`   | exact-match (quoted)       | `wild`で完全一致   |
| `^music`  | prefix-exact-match         | `music`で始まる      |
| `.mp3$`   | suffix-exact-match         | `.mp3`で終わる       |
| `!fire`   | inverse-exact-match        | `fire`を含まない      |
| `!^music` | inverse-prefix-exact-match | `music`で始まらない    |
| `!.mp3$`  | inverse-suffix-exact-match | `.mp3`で終わらない     |
