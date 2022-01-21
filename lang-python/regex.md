# pythonの正規表現

## groupとgroupsの違い

- groupは引数に渡したn番目のgroupが返る
  - 0はマッチ全体
  - 引数が複数ならタプルで返る
- groupsはマッチしたgroupがタプルで返る

```python
def test_group2():
    s = "123"
    m = re.search(r"(\d*)(\d*?)(\d+)", s)
    g = m.group(0, 1, 2, 3)
    gs = m.groups()
    assert g == ("123", "12", "", "3")
    assert gs == ("12", "", "3")
    assert m.group(1) == m.groups()[0]
    assert m.group(3) == m.groups()[2]
```
