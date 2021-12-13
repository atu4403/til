# pytestあれこれ

## plugins

pytestとは別のパッケージ集

### pytest-timeout

timeoutを設定する。pytest.iniに追記することで有効化する。以下の例では5秒を過ぎたらtimeoutでtest失敗となる。

```bash
timeout = 5
```
