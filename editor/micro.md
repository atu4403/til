# micro

[Micro - Home](https://micro-editor.github.io/index.html)

## Keybindings

| key             | command                                 |
|:----------------|:----------------------------------------|
| ctrl-s          | save                                    |
| ctrl-q          | quit                                    |
| Alt-Left        | 単語単位で左へ移動                        |
| Alt-Right       | 単語単位で右へ移動                        |
| Alt-Up          | 行を上へ移動                              |
| Alt-Down        | 行を下へ移動                              |
| Alt-Shift-Right | 単語の終端まで選択                         |
| Alt-Shift-Left  | 単語の先頭まで選択                         |
| Ctrl-Shift-Up   | 上を全部選択                             |
| Ctrl-Shift-Down | 下をを全部選択                            |
| Tab             | Autocomplete,IndentSelection,InsertTab, |
| Ctrl-f          | Find,                                   |
| Ctrl-n          | FindNext,                               |
| Ctrl-p          | FindPrevious,                           |
| Ctrl-z          | Undo,                                   |
| Ctrl-y          | Redo,                                   |
| Ctrl-c          | CopyLine,Copy,                          |
| Ctrl-x          | Cut,                                    |
| Ctrl-k          | CutLine,                                |
| Ctrl-d          | DuplicateLine,                          |
| Ctrl-v          | Paste,                                  |
| Ctrl-a          | SelectAll,                              |
| Home            | 行頭へ移動                               |
| End             | 行末へ移動                               |
| CtrlHome        | 最上段の先頭へ移動                        |
| CtrlEnd         | 最下段の終端へ移動                        |
| Ctrl-l          | 指定した行へ移動                           |
| Ctrl-e          | CommandMode,                            |
| Alt-Shift-Up    | マルチカーソルを上に追加                         |
| Alt-Shift-Down  | マルチカーソルを下に追加                         |

// Integration with file managers
"F2":  "Save",
"F3":  "Find",
"F4":  "Quit",
"F7":  "Find",
"F10": "Quit",
"Esc": "Escape",

## commands

`ctrl-e`でコマンドモード

- goto 25
- replace xxx yyy
- replaceall xxx yyy

## color

`ctrl-e`でコマンドモードに入り、`set colorscheme <theme>`

set colorscheme twilight

![micro](/images/micro/2021-12-22-21-07-51.png)

set colorscheme zenburn

![micro](/images/micro/2021-12-22-21-08-52.png)

set colorscheme gruvbox

![micro](/images/micro/2021-12-22-21-10-35.png)

set colorscheme darcula

![micro](/images/micro/2021-12-22-21-10-58.png)

set colorscheme railscast

![micro](/images/micro/2021-12-22-21-11-23.png)
