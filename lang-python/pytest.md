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

## plugins

pytestとは別のサードパーティパッケージ集

### pytest-timeout

timeoutを設定する。pytest.iniに追記することで有効化する。以下の例では5秒を過ぎたらtimeoutでtest失敗となる。

```bash
timeout = 5
```
