# pytestあれこれ

## tips

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
