# All Green

[C - All Green](https://atcoder.jp/contests/abc104/tasks/abc104_c)

```bash
2 700 # D  G
3 500 # p1 c1 (100点問題)
5 800 # pD cD (200点問題)
```

```bash
3
```

この問題で各難易度の問題について以下の選択肢がある。

- １問も解かない
- 全部解く
- 半端に解く(1問以上全問未満)

この「半端に解く」のは1つの難易度に限り、複数に渡って「半端に解く」のはありえない。

上記の例で100点問題を2問、200点問題を2問で条件を達成できるとしても、同じ4問解くなら200点問題を4問解く方がより早く条件達成できる可能性があるから。仮に200点問題が3問しかないのなら「100点問題を1問、200点問題をコンプリート」となるので「半端に解く」のは１つの難易度に限られる。

そうなると

- １問も解かない
- 全部解く
- 全部解いたうちの１つを半端に解いて条件が達成できるのなら回数を減らせる

このうち「１問も解かない」を排除したものをビット全探索する。

```python
import sys
import copy
from itertools import combinations


def comb_search(n):
    for i in range(n + 1):
        for t in combinations(range(n), i):
            yield t


def solve(D, G, p, c):
    ans = sys.maxsize
    val = {}
    for i in range(D):
        cost = (i + 1) * 100
        bonus = cost * p[i] + c[i]
        val[i] = {"cost": cost, "bonus": bonus, "count": p[i]}
    for T in comb_search(D):
        mx = {"sum": 0, "count": 0}
        for t in T:
            mx["sum"] += val[t]["bonus"]
            mx["count"] += val[t]["count"]
        if mx["sum"] < G:
            continue
        sm, cnt = 0, 0
        for t in T:
            ref = copy.deepcopy(mx)
            ref["sum"] -= val[t]["bonus"]
            ref["count"] -= val[t]["count"]
            rest = G - ref["sum"]
            d = 0
            if rest > 0:
                d, m = divmod(rest, val[t]["cost"])
                if m:
                    d += 1
            ref["count"] += d
            ref["sum"] += d * val[t]["cost"]
            if ref["sum"] >= G:
                ans = min([ans, ref["count"], mx["count"]])
    return ans


def main():
    D, G = map(int, input().split())
    p = [None for _ in range(D)]
    c = [None for _ in range(D)]
    for i in range(D):
        p[i], c[i] = map(int, input().split())
    a = solve(D, G, p, c)
    print(a)


if __name__ == "__main__":
    main()
```
