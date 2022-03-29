# 新規プロジェクトにいつものファイルを準備するcookiecutter

[Cookiecutter: Better Project Templates — cookiecutter 1.7.2 documentation](https://cookiecutter.readthedocs.io/en/1.7.2/index.html)

新規プロジェクトを作るたびにREADME.mdやLICENSE等のファイルを作るのは面倒。それ以外にも言語ごとに固有のリント設定やtest設定、ソースファイルの雛形等を自動で作成してくれるのがcookiecutterです。

> cookiecutterはpython製なのでインストールにはpythonが必要です。
> しかしインストール後に使用するにはpythonの知識は不要です。

当然プロジェクトごとに必要なファイルは様々なのでcookiecutterで使用するテンプレートも世界中で作られています。python,goを始め色々な言語やフレームワークで必要なテンプレートがあります。

[Search · cookiecutter](https://github.com/search?q=cookiecutter)

GitHubに上がっているテンプレートや、自作のテンプレートのパスを指定することで実行できます。

```bash
cookiecutter https://github.com/audreyr/cookiecutter-pypackage.git
cookiecutter /path/to/cookiecutter-pypackage/
```

起動すると対話式で必要な情報を入力していきます。入力が終わると適切なファイルが含まれる新規プロジェクトが作成されます。

```bash
> cookiecutter /path/to/cookiecutter-poetry
full_name [atu4403]:
email [73111778+atu4403@users.noreply.github.com]:
github_username [atu4403]:
project_name [Python Boilerplate]: moncoll2
project_slug [moncoll2]:
pypi_username [atu4403]:
Select command_line_interface:
1 - Click
2 - Fire
3 - No command-line interface
Choose from 1, 2, 3 [1]: 3
Select open_source_license:
1 - MIT license
2 - BSD license
3 - ISC license
4 - Apache Software License 2.0
5 - GNU General Public License v3
6 - Not open source
Choose from 1, 2, 3, 4, 5, 6 [1]: 1
```

```bash
> tree --dirsfirst
.
├── src
│   └── moncoll2
│       ├── __init__.py
│       └── cli.py
├── tests
│   ├── __init__.py
│   └── test_moncoll2.py
├── LICENSE
├── README.md
├── poetry.lock
└── pyproject.toml
```

`~/.cookiecutterrc`を作成して入力のデフォルト値やテンプレートのエイリアスを指定できます。

```bash
> cat ~/.cookiecutterrc
default_context:
  full_name: 'atu4403'
  email: '73111778+atu4403@users.noreply.github.com'
  github_username: 'atu4403'
abbreviations:
  pp: https://github.com/audreyr/cookiecutter-pypackage.git
  poetry: /Users/atu/Documents/python/cookiecutter-simple-poetry
```

## with ghq

`ghq create`コマンドは適切なディレクトリにリポジトリを作成できますが、cookiecutterの機能と被ってしまいます。

通常では`project_slug`等で指定したディレクトリがすでに存在するとcookiecutterは何もしません。しかし`-f`オプションを付けるとディレクトリが存在しても上書きしてファイルを作成します。`ghq create`が行うのは`git init`だけなので重複せずにプロジェクトを作成できます。

```bash
ghq create hoge
cd ~/ghq/github.com/atu4403 #作成したhogeディレクトリの親ディレクトリに移動
cookiecutter poetry -f
```
