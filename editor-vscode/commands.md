# vscodeのコマンド

## vscode insidersのコマンドを追加する方法

pathの通っているディレクトリ(`/usr/local/bin`等)にリンクを貼る

```bash
cd /usr/local
ln -s "/Applications/Visual Studio Code - Insiders.app/Contents/Resources/app/bin/code" insiders
```

## バージョン表示

```bash
> code --version
1.63.0
7db1a2b88f7557e0a43fec75b6ba7e50b3e9f77e
x64
```

insiders

```bash
> insiders --version
1.64.0-insider
7b9e5c32a053669d4e72f998e4fa217090c32f59
x64
```

## 拡張機能の一覧

```bash
> code --list-extensions
chunsen.bracket-select
donjayamanne.githistory
esbenp.prettier-vscode
fiore57.snippet-generator
GitHub.copilot
hbenl.vscode-test-explorer
inu1255.easy-snippet
littlefoxteam.vscode-python-test-adapter
ms-azuretools.vscode-docker
MS-CEINTL.vscode-language-pack-ja
ms-python.python
ms-python.vscode-pylance
ms-toolsai.jupyter
ms-toolsai.jupyter-keymap
ms-toolsai.jupyter-renderers
ms-vscode-remote.remote-containers
ms-vscode.atom-keybindings
ms-vscode.test-adapter-converter
njpwerner.autodocstring
sleistner.vscode-fileutils
```

バージョンも一緒に表示

```bash
> code --list-extensions --show-versions
chunsen.bracket-select@2.0.2
donjayamanne.githistory@0.6.19
esbenp.prettier-vscode@9.0.0
fiore57.snippet-generator@1.0.0
GitHub.copilot@1.7.4421
hbenl.vscode-test-explorer@2.21.1
inu1255.easy-snippet@0.6.3
littlefoxteam.vscode-python-test-adapter@0.7.0
ms-azuretools.vscode-docker@1.18.0
MS-CEINTL.vscode-language-pack-ja@1.64.1
ms-python.python@2022.0.1612153341-dev
ms-python.vscode-pylance@2021.12.3-pre.1
ms-toolsai.jupyter@2022.1.1001614873
ms-toolsai.jupyter-keymap@1.0.0
ms-toolsai.jupyter-renderers@1.0.4
ms-vscode-remote.remote-containers@0.209.6
ms-vscode.atom-keybindings@3.0.9
ms-vscode.test-adapter-converter@0.1.5
njpwerner.autodocstring@0.5.4
sleistner.vscode-fileutils@3.4.5
```

## status表示

```bash
> code --status
Version:          Code 1.63.0 (7db1a2b88f7557e0a43fec75b6ba7e50b3e9f77e, 2021-12-07T05:15:48.091Z)
OS Version:       Darwin x64 18.7.0
CPUs:             Intel(R) Core(TM) i5-5287U CPU @ 2.90GHz (4 x 2900)
Memory (System):  16.00GB (0.06GB free)
Load (avg):       3, 3, 3
VM:               0%
Screen Reader:    no
Process Argv:     --crash-reporter-id dd47524e-5b64-4650-9787-46aabc4b671c
GPU Status:       2d_canvas:                  enabled
                  gpu_compositing:            enabled
                  metal:                      disabled_off
                  multiple_raster_threads:    enabled_on
                  oop_rasterization:          enabled
                  opengl:                     enabled_on
                  rasterization:              enabled
                  skia_renderer:              disabled_off_ok
                  video_decode:               enabled
                  webgl:                      enabled
                  webgl2:                     enabled

CPU %  Mem MB     PID  Process
    2     147    2045  code main
    0      66    2048     gpu-process
    0      33    2051     utility-network-service
    0     115    2064     shared-process
    0      33    2066       ptyHost
    0       0   86849         /usr/local/bin/fish -l
    0      33   86836       watcherServiceParcelSharedProcess
    0     131   37978     window (undefined)
    0     311   86825     window (commands.md — til)
    0     164   86833     extensionHost
    0      33   87291       /Applications/Visual Studio Code.app/Contents/MacOS/Electron --ms-enable-electron-run-as-node /Users/atu/.vscode/extensions/dbaeumer.vscode-eslint-2.2.2/server/out/eslintServer.js --node-ipc --clientProcessId=86833

Workspace Stats:
|  Window (commands.md — til)
|    Folder (til): 107 files
|      File types: md(54) png(19) DS_Store(3) fish(3) gitignore(1) json(1)
|                  gif(1)
|      Conf files: settings.json(1)
```
