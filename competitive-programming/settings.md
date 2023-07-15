# WIP 競技プログラミング(at coder)の環境構築: python

極論を言うと、AtCoderに参加するにはブラウザだけでできます。
頭の中で描いたコードを解答欄に書き、提出ボタンを押すだけです。

![解答欄イメージ](/images/settings/2023-05-16-14-18-39.png)

しかし誤答にはペナルティがあるので、できれば手元でコードを動かし、動作テストしてから投稿したいものです。

動作テストを行うためには、解答コードの他にも必要なものがあります。問題文に含まれる「入力例」です。これを問題ごとにブラウザからコピペするのも、答えが間違っていないか出力例を確認するのも手間になります。

## online-judge-tools

online-judge-tools(略称oj)を使うと、問題（入力例）の一括ダウンロードや、コマンド一発でテストや提出が可能です。online-judge-template-generatorを併用すると、解答コードを書くためのファイルも自動生成されます。

![自動生成されたディレクトリ](/images/settings/2023-05-16-14-33-52.png)

問題ごとに自動生成されたmain.pyに解答を書き、コマンド`oj t -c "python main.py"`と打ち込めば全ての入力例でテストが行われます。

main.pyは以下のような感じで生成されます。

```python

def solve(N, A):
    pass

def main():
    import sys
    tokens = iter(sys.stdin.read().split())
    N = int(next(tokens))
    A = [None for _ in range(N)]
    for i in range(N):
        A[i] = int(next(tokens))
    assert next(tokens, None) is None
    ans = solve(N, A)
    print(ans)  # TODO: edit here

if __name__ == '__main__':
    main()

```

本来なら入力を受け取る部分から書く必要がありますが、online-judge-template-generatorでtemplateを登録していればそれも作成してくれます。(ただし問題によっては適切に作成できていないこともあります)
この例では変数N,Aが用意された状態から書き始めることができるので、solve関数に書き込んでいくだけです。

## vscodeとの連携

かなり便利になりましたが、今度はコマンドラインに`oj t -c "python main.py"`と打ち込むのが手間です。このコマンドを打つには現在解いている問題の`main.py`があるディレクトリに移動する必要があります。

vscodeの`keybindings.json`ににショートカットを登録することで、これも自動化できます。

下記の例では`ctrl + alt + o`を押すだけでテストを実行できるようになります。

```keybindings.json
  {
    "key": "ctrl+alt+o",
    "command": "workbench.action.terminal.sendSequence",
    "args": {
      "text": "cd ${fileDirname} && ojt\n"
    }
  },
```

## 概念の紹介

ここでは一連のフローやできることを解説していきます。

### online-judge-tools

- コマンドラインツール
- Atcoderなどのオンラインジャッジをアシストしてくれる
- できること
  - 問題のサンプルをダウンロード
  - 問題のテスト
  - 解答の提出
  - コマンドラインからファイルを実行できる言語なら使用可能
- できないこと
  - コンテストの問題の一括ダウンロード
  - テンプレートの生成
- 参考: [oj/getting-started.ja.md at master · online-judge-tools/oj · GitHub](https://github.com/online-judge-tools/oj/blob/master/docs/getting-started.ja.md#getting-started-for-oj-command-%E6%97%A5%E6%9C%AC%E8%AA%9E)

![](/images/settings/2023-05-17-12-33-39.png)

### [online-judge-tools/template-generator](https://github.com/online-judge-tools/template-generator)

- コマンドラインツール
- online-judge-toolsのプラグイン的なツール
- できること
  - コンテスト単位でのサンプル一括ダウンロード
  - コンテストごとにディレクトリの自動作成
  - 解答ファイルをテンプレートから自動作成
- 参考: [template-generator/README.ja.md at master · online-judge-tools/template-generator · GitHub](https://github.com/online-judge-tools/template-generator/blob/master/README.ja.md)

### vscode

- 多機能テキストエディタ
- ショートカットキーでコマンドラインを操作する機能がある

## 手順

### ディレクトリ構成

ディレクトリ構成については各々好みがあると思いますので、参考程度に私の場合をご紹介します。
`atcoder-lesson`というディレクトリ以下、次のような構成にしています。

```bash
> tree -L 3
.
├── .python-version # pythonバージョンの指定
├── .venv           # 仮想環境
├── poetry.lock     # poetryで自動生成される
├── problems        # 問題サンプル、解答ファイルが展開されるディレクトリ
│   └── atcoder.jp
│       ├── abc301
│       └── abs
└── pyproject.toml  # poetryの設定ファイル
```

### 1. ojとoj/template-generatorのインストール

`pip`だったり`poetry`だったり色々な環境構築方法がありますので省略します。注意する点としては、オンラインジャッジごとに言語のバージョンが違いますので（記事執筆時点でpythonは3.8）仮想環境(pythonならvenv等)を作ってインストールすることをおすすめします。

### 2. oj/template-generatorの設定

template-generatorでは`oj-prepare`コマンドにより、コンテストの一括ダウンロードができます。その場合にファイル群を展開する場所を設定します。
`~/.config/online-judge-tools/prepare.config.toml`という設定ファイルを作って以下のように書きます。

```bash
contest_directory = "~/Desktop/{service_domain}/{contest_id}/{problem_id}"
problem_directory = "."

[templates]
"main.py" = "main.py"
"naive.py" = "main.py"
"generate.py" = "generate.py"
``
