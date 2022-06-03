# csvをsqliteに突っ込む方法


https://www.post.japanpost.jp/zipcode/download.html

```python
def test_01():
    from sqlite3 import connect
    import pandas as pd

    df = pd.read_csv(
        "KEN_ALL_ROME.CSV",
        encoding="SHIFT-JIS",
        index_col=None,
        header=None,
        names=[
            "code",
            "state",
            "city",
            "address",
            "state_r",
            "city_r",
            "address_r",
        ],
    )
    print(df.head())
    print(df.columns)
    file_sqlite3 = "./postcode.db"
    conn = connect(file_sqlite3)
    df.to_sql("codes", conn, if_exists="replace", index=0)
    cur = conn.cursor()
    cur.execute("SELECT * FROM codes LIMIT 5")
    print(cur.fetchall())
    cur.close()
    conn.close()
```
