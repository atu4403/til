# micro

[Micro - Home](https://micro-editor.github.io/index.html)

## Keybindings

| key             | command                                 |
|:----------------|:----------------------------------------|
| ctrl-s          | save                                    |
| ctrl-q          | quit                                    |
| Alt-Left        | WordLeft, (Mac)                         |
| Alt-Right       | WordRight, (Mac)                        |
| Alt-Up          | MoveLinesUp,                            |
| Alt-Down        | MoveLinesDown,                          |
| Alt-Shift-Right | SelectWordRight, (Mac)                  |
| Alt-Shift-Left  | SelectWordLeft, (Mac)                   |
| Ctrl-Shift-Up   | SelectToStart,                          |
| Ctrl-Shift-Down | SelectToEnd,                            |
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
| Home            | StartOfText,                            |
| End             | EndOfLine,                              |
| CtrlHome        | CursorStart,                            |
| CtrlEnd         | CursorEnd,                              |
| Ctrl-l          | command-edit,goto ,                     |
| Ctrl-b          | ShellMode,                              |
| Ctrl-e          | CommandMode,                            |
| Alt-Shift-Up    | SpawnMultiCursorUp,                     |
| Alt-Shift-Down  | SpawnMultiCursorDown,                   |

// Integration with file managers
"F2":  "Save",
"F3":  "Find",
"F4":  "Quit",
"F7":  "Find",
"F10": "Quit",
"Esc": "Escape",

## commands

`ctrl-e`でコマンドモード

goto 25
replace xxx yyy
replaceall xxx yyy

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
