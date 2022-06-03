# 累積和問題を解く

## itertools.accumulate

pythonでは`itertools.accumulate`を使って累積和を作成できる。

```python
from itertools import accumulate

li = [1, 2, 3, 4, 5]
a = list(accumulate(li))
# a [1, 3, 6, 10, 15]
```

一般的には以下のように作成する。

```python
li = [1, 2, 3, 4, 5]
b = [0]
for i in range(len(li)):
    b.append(b[-1] + li[i])
# b [0, 1, 3, 6, 10, 15]

```

このように、一般的な累積和は頭に`0`が入る。accumulateを使って同様にするには引数`initial`を指定する。(python3.8以降)

```python
list(accumulate(li, initial=0))
# [0, 1, 3, 6, 10, 15]
[0] + list(accumulate(l)) # python3.8以前の場合
# [0, 1, 3, 6, 10, 15]
```

速度的にはaccumulateを使った方が速い上に、簡潔に書けるので使わない手はない。

```python

from timeit2 import ti2


def a(l):
    return list(accumulate(l, initial=0))


def b(l):
    return [0] + list(accumulate(l))


def c(l):
    a = [0]
    for i in range(len(l)):
        a.append(a[-1] + l[i])
    return a


l = [i + 3 for i in range(10000)]
ti2(a, b, c, args=[l], relative=True)

# a:
#     0.000298 sec
# b:
#     0.000339 sec
# c:
#     0.001440 sec
# relative:
#     a:
#         1
#     b:
#         1.14
#     c:
#         4.83
```

頭に`0`を付ける「一般的な累積和」と「accumulate関数の累積和」はどちらを使うのが良いか。

例えば「要素数Kの和を全て求めよ」というような問題では「一般的な累積和」の方が簡潔に書ける。

しかし累積和を元に新しい配列を作成するような場合だと「一般的な累積和」は要素数が増えてしまうので使いにくい場合がある。

なので「一般的な累積和」と「accumulate関数の累積和」は用途によって使い分けるのが良い。

## 例題

### K個の部分和を求める

長さNの数列Aが与えられる。K個の部分和の〇〇を求めよ

1. 部分和の最大値
2. 部分和がX以上のものの個数

```python
# 5 3
# 1 3 5 2 4
# 累積和0始まりバージョン
from itertools import accumulate

N, K = map(int, input().split())
A = list(map(int, input().split()))
a = list(accumulate(A, initial=0))
ans = 0
for i in range(K, N + 1):
    v = a[i] - a[i - K]
    print("v: ", v)
# v:  9
# v:  10
# v:  11
```

ポイント

- `range(K, N + 1):`
  - 累積和`a`は冒頭に`0`が追加されているので長さが`N+1`になる
  - `K=3`と仮定して「要素数3の部分和」に`[-2:0]`や`[-1:1]`は不要なので始まりが`K`となる
- 累積和`[0, 1, 4, 9, 11, 15]`は`0`始まりが最適
  - 0始まりじゃない`[1, 4, 9, 11, 15]`だと`[0:2]`の部分和を取るのに特別な処理が必要になる
  - `v = a[i] if i==K else a[i] - a[i - K]`みたいな感じ

### 2つに分ける

長さNの数列Aが与えられる。数列Aのどこかに仕切りを入れ左側の和を`l`、右側の和を`r`とする。

1. `|l-r|`が最も小さくなる仕切りの位置を求めよ
2. 最も大きい`l × r`を求めよ

```python
N = 5
A = [1, 2, 3, 4, 5]
a = list(accumulate(A, initial=0))
ans = 0
for i in range(N + 1):
    l = a[i]
    r = a[-1] - a[i]
    print(f"{i}: {l} {r}")

# a:  [0, 1, 3, 6, 10, 15]
# 0: 0 15
# 1: 1 14
# 2: 3 12
# 3: 6 9
# 4: 10 5
# 5: 15 0
```

応用で「2つに分ける」ではなく「左右それぞれからn個取る」パターンもある。

```python
for i in range(N + 1):
    l = a[i]
    r = a[-1] - a[-1 - i]
    print(f"{i}: {l} {r}")
# a:  [0, 1, 3, 6, 10, 15]
# 0: 0 0
# 1: 1 5
# 2: 3 9
# 3: 6 12
# 4: 10 14
# 5: 15 15
```

### 関数を指定する

accumulate関数は第2引数に関数を渡すことができる。指定しない場合は`operator.add`が使われるが、これを差し替えることができる。

```python
li = [1, 2, 5, 4, 6, 3]
list(accumulate(li, max))
# [1, 2, 5, 5, 6, 6]
```

もちろんlambda式で書くことも可能。この場合2つの引数が必要になる。totalは累積の値、elementは各要素の値となる。

```python
lambda total, element: max(total, element)
```

## 問題を解く

### A - Max Add

[A - Max Add](https://atcoder.jp/contests/arc120/tasks/arc120_a)

$i$までの最大値を$MX$、$i$までの累積和を$AC$とすると以下と同義になる。

$$
    MX \times i + \sum_{i=1}^n AC_i
$$

$\sum_{i=1}^n AC_i$は累積和の累積和なので、この部分も先に計算しておくと以下のように書ける。

```python
from itertools import accumulate


def solve(N, A):
    a = list(accumulate(A))
    b = list(accumulate(A, max))
    c = list(accumulate(a))
    for i in range(N):
        print(b[i] * (i + 1) + c[i])


def main():
    import sys

    tokens = iter(sys.stdin.read().split())
    N = int(next(tokens))
    A = [None for _ in range(N)]
    for i in range(N):
        A[i] = int(next(tokens))
    assert next(tokens, None) is None
    solve(N, A)


if __name__ == "__main__":
    main()

```

### B - Iron Bar Cutting

[B - Iron Bar Cutting](https://atcoder.jp/contests/ddcc2020-qual/tasks/ddcc2020_qual_b)

棒の各区間の長さが`[2 4 3]`の場合、2つに分けると`[2 (4+3)]`もしくは`[(2+4) 3]`になる。前者の場合2つの絶対差は5、後者の絶対差は3となり、この小さい方がそのまま答えになる。

```python
def solve(N, A):
    a = list(accumulate(A))
    mx = a[-1]
    b = []
    for i in range(N):
        b.append(abs((mx - a[i]) - a[i]))
    return min(b)
```

bの作成部分をaccumulate関数で作成することも可能だが、可読性を考慮して上記のようにしている。

### D - Dice in Line

[D - Dice in Line](https://atcoder.jp/contests/abc154/tasks/abc154_d)

「サイコロの期待値」がわからなくてググった。6面のサイコロなら期待値は以下の通り。

$$
    (1+2+3+4+5+6) \div6
$$

$1$から$N$までの総和は$N\times(N+1)\div2$で求まるので、期待値の累積和を作ると初級編の累積和問題になる。

```python
def exp(n):
    return n * (n + 1) // 2 / n


def solve(N, K, P):
    li = [exp(p) for p in P]
    a = list(accumulate(li, initial=0))
    mx = -1
    for i in range(N + 1):
        if i + K < N + 1:
            mx = max(mx, a[i + K] - a[i])
    return mx
```

## その他累積和の問題

### 単純な累積和

[C - Attention](https://atcoder.jp/contests/arc098/tasks/arc098_a)
[C - GeT AC](https://atcoder.jp/contests/abc122/tasks/abc122_c)
[C - Splitting Pile](https://atcoder.jp/contests/abc067/tasks/arc078_a)
[C - 総和](https://atcoder.jp/contests/abc037/tasks/abc037_c)

### 累積和の応用

[D - Wandering](https://atcoder.jp/contests/abc182/tasks/abc182_d)
[C - Tsundoku](https://atcoder.jp/contests/abc172/tasks/abc172_c)(累積和+尺取法、または二分探索でも可)
[C - Stones](https://atcoder.jp/contests/tenka1-2019-beginner/tasks/tenka1_2019_c)
[D - Sum of Large Numbers](https://atcoder.jp/contests/abc163/tasks/abc163_d)

### 雑感

難しい問題になると累積和で解けると知っていてもわからない。また、累積和意外の解法が存在することも多い。
