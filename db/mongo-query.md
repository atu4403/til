# mongodbのqueryあれこれ

[Query and Projection Operators — MongoDB Manual](https://docs.mongodb.com/manual/reference/operator/query/)

## 比較

| オペレータ | 機能   | 例                             |
|:------|:------|:-------------------------------|
| $eq   | 等しい   | `{"$eq": 3}` (3)               |
| $ne   | 等しくない | `{"$ne": 3}` (3以外)           |
| $gt   | より大きい | `{"$gt": 3}` (4以上)           |
| $gte  | 以上   | `{"$gte": 3}` (3以上)          |
| $lte  | 以下   | `{"$lte": 3}` (3以下)          |
| $lt   | 未満   | `{"$lt": 3}` (2以下)           |
| $in   | 含む    | `{"$in": [5, 15]}` (5か15)      |
| $nin  | 含まない  | `{"$nin": [5, 15]}` (5,15以外) |

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
