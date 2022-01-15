# pytestあれこれ

## tips

### カバレッジ

```bash
poetry add pytest-cov -D
pytest --cov=src --cov-report=html tests/
```

### warning.warnのtest

```py
import pytest

def test_download():
    """ urlが存在しない場合、warningが出て0が返る"""
    url = "https://www.google.com/example"
    with pytest.warns(UserWarning) as record:
        assert download(url, "down_test.html") == 0
        assert record[0].message.args[0] == "404: Not Found"
        assert record[1].message.args[0] == "url: https://www.google.com/example"
```

### fixture

```py
import pytest

class TestEdinet:
    @pytest.fixture(scope="class")
    def edinet(self):
        return Edinet('71870/S100APUT.zip')

    def test_basic(self, edinet):
        assert edinet.filename == '71870/S100APUT.zip'
        assert edinet.xbrl_filenames[0] == 'XBRL/PublicDoc/jpcrp030000-asr-001_E32412-000_2017-03-31_01_2017-06-30.xbrl'
        assert edinet.xbrl_length == 1
```

1. pytestをimport
2. `@pytest.fixture`で定義
3. 使用部分で`def test_basic(self, edinet):`と引数として渡す

### skip

```py
import pytest

@pytest.mark.skip(reason="skipする理由を書く")
def test_each_files():
    pass
```

### mark

```python
@pytest.mark.heavy
def test_foo():
    pass
```

```bash
# pytest.ini
[pytest]
addopts = -vv --capture=no -m "not heavy" --strict-markers
markers =
    heavy: 重い処理を伴うtest
```

この設定により、通常の`pytest`ではheavyのtestは実行されない。
heavyを実行する場合は`pytest -m heavy`とする。

### raises

```py
import pytest

class TestVariable:
    def test_isfile(self):
        with pytest.raises(FileExistsError) as excinfo:
            Variable(__file__)
        assert 'Specify a directory instead of a file' in str(excinfo.value)
```

### doctest

```bash
pytest --doctest-modules
```

### 前後処理

fixtureでyieldする

```python
@pytest.fixture()
def path(self):
    # 前処理
    yield 'path/to/file'
    # 後処理
```

### 値を隠蔽する

例えばDBのtestに使うパスワードをGitHubに上げずに隠したい時のtips。環境変数を使う等色々な方法があるが、ローカルのファイルを使った方法。

`~/.mongouri`というファイルにmongodbのuri(パス含む)を書き、conftest.pyでfixtureとして読み込む。

```py
import pytest
from pathlib import Path

@pytest.fixture(scope="module", autouse=True)
def url():
    mongouri_file = Path.home() / '.mongouri'
    if mongouri_file.exists():
        return mongouri_file.read_text().split("\n")[0]
    else:
        return "mongodb://root:example@localhost/?authMechanism=DEFAULT"
```

jsonを使う場合

```python
import payhlib
import json

@pytest.fixture()
def settings():
    settings_path = Path.home() / '.config/mongos/test_settings.json'
    if settings_path.exists():
        return json.loads(settings_path.read_text())
    else:
        return {
            "username": "testuser",
            "password": "testpass",
            "host": "localhost",
            "port": 12345,
            "coll_name": "test_collenction",
            "db_name": "test_db"
        }
```

### 一時ディレクトリでtestを行う

例えばファイルを作成する関数のtestを行う時にTMPDIRで作成し環境を汚さないようにする例

```python
# https://py.readthedocs.io/en/latest/path.html
import os
import pytest


@pytest.fixture
def d(tmpdir) -> str:
    p = tmpdir.chdir()
    yield
    p.chdir()


def test_tmpdir(d):
    a = os.getcwd()
    assert (
        a
        != "/private/var/folders/gc/1js4q5b53fjblxs9z0fsj17h0000gn/T/pytest-of-atu/pytest-7/test_tmpdir0"
    )
```

- `assert a !=`としているのは毎回違うディレクトリが割り当てられるので。
- `/private/var/folders/gc`というTMPDIRは3日で削除されるらしい
- [macos の TMPDIR に作成したファイル・ディレクトリはいつ削除される？ - スタック・オーバーフロー](https://ja.stackoverflow.com/questions/57956/macos-%E3%81%AE-tmpdir-%E3%81%AB%E4%BD%9C%E6%88%90%E3%81%97%E3%81%9F%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB-%E3%83%87%E3%82%A3%E3%83%AC%E3%82%AF%E3%83%88%E3%83%AA%E3%81%AF%E3%81%84%E3%81%A4%E5%89%8A%E9%99%A4%E3%81%95%E3%82%8C%E3%82%8B)

## plugins

pytestとは別のサードパーティパッケージ集

### pytest-timeout

timeoutを設定する。pytest.iniに追記することで有効化する。以下の例では5秒を過ぎたらtimeoutでtest失敗となる。

```bash
timeout = 5
```

## errors

GitHub Actionsでpytestを行うと、windowsでエラーが出た。

```python
  File "c:\hostedtoolcache\windows\python\3.8.10\x64\lib\encodings\cp1252.py", line 23, in decode
    return codecs.charmap_decode(input,self.errors,decoding_table)[0]
  UnicodeDecodeError: 'charmap' codec can't decode byte 0x8d in position 94: character maps to <undefined>
  Error: Process completed with exit code 1.
```

どうやらencodeがおかしいようで、pythonはutf8で読み込むようにする環境変数があるらしい。これを設定したら通った。

.github/workflows/test.yml

```yaml
  with:
    poetry-version: 1.0
- run: |
    export PYTHONUTF8=1
    poetry install
    poetry run pytest
  shell: bash
```
