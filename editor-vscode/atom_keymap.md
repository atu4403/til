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
