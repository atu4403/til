# WIP

## 最小限のconfig.fishの作り方

- そもそも`.zshrc`や`.bashrc`は必要不可欠
- fishはユニバーサル変数によりPATH等が永続化できるので設定不要？
- 関数は`functions`に置ける
- 補完設定は`completions`に置ける
- ユニバーサル変数は`fish_variables`に自動で書き込まれる

## rcファイルに書いてあること

- path
- その他環境変数
- 関数
- lscolors
- プロンプト
- キーバインド: fish_user_key_bindings
- sourceによる読み込み
- evalによる読み込み
- historyの設定
- alias
