# mongodbのqueryあれこれ

## 空文字を弾く

`$eq`はequal、`$ne`はnot equalなのでこれを使う。

```bash
{xbrl: {$ne: ""}}
```

aggregateの場合

```python
[
    {"$match": {"xbrl": {"$ne": ""}}}
]
```
