# pythonでビット全探索

## ビット全探索とは

0個以上の要素を選んだ組み合わせを求めることができる。

```python
def bit_search(n):
    li = range(n + 1)
    for i in range(2 ** n):
        ref = []
        for j in range(n):
            if (i >> j) & 1:
                ref.append(li[j])
        yield tuple(ref)


for t in bit_search(3):
    print(t)
# ()
# (0,)
# (1,)
# (0, 1)
# (2,)
# (0, 2)
# (1, 2)
# (0, 1, 2)
```

- 何も選ばない`()`
- 1つ選ぶ(`(1)`他)
- 2つ選ぶ(`(0, 2)`他)
- 3つ選ぶ`(0, 1, 2)`

これらの組み合わせをイテレートするのが基本。

> わざわざビット全探索部分を関数化せずに直接書く方法もありますし、関数化することで遅くなる場合もありますが、関数化により理解しやすくなりますのでこのままお付き合いください。

### 例題: N個の硬貨Aからそれぞれ0個もしくは1個選んだ場合の合計額をそれぞれ求めよ

入力

```bash
3
1 10 100
```

出力

```bash
0
1
10
11
100
101
110
111
```

解答例

```python
N = int(input())
A = list(map(int, input().split()))
for t in bit_search(N):
    ans = 0
    for i in t:
        ans += A[i]
    print(ans)
```

## 応用編

[C - たくさんの数式](https://atcoder.jp/contests/abc045/tasks/arc061_a)

'0-9'からなる文字列Sに0個以上の'+'を挿入して式を作り総和を求めよ、という問題。

仮にS='125'なら 125 、 1+25 、 12+5 、 1+2+5 の総和を計算する。

これをビット全探索で書くと以下のようになる。

```python
def bit_search(n):
    li = range(n + 1)
    for i in range(2 ** n):
        ref = []
        for j in range(n):
            if (i >> j) & 1:
                ref.append(li[j])
        yield tuple(ref)

N = input()
ans = 0
for t in bit_search(len(N) - 1):
    s = N[0]
    for i in range(1, len(N)):
        if i - 1 in t:
            s += "+"
        s += N[i]
    ans += eval(s)
print(ans)
```

フラグが立ってたら文字列の間に`+`を入れ、立ってないなら何も入れないという処理だが若干ややこしい。そこで「フラグが立っていないなら何も入れない」ではなく「空文字を入れる」という処理に変更する。

```python
def bit_search(n):
    li = range(n + 1)
    for i in range(2 ** n):
        ref = []
        for j in range(n):
            if (i >> j) & 1:
                ref.append("+")
            else:
                ref.append("")
        yield tuple(ref)

N = input()
s = N.replace("", "{}").strip("{}")
ans = 0
for t in bit_search(len(N) - 1):
    ans += eval(s.format(*t))
print(ans)
```

これでちょっとだけわかりやすくなった。
このように、主にビット全探索には二通りある

1. フラグが立っていたら何かをする
2. フラグが立っている場合と立っていない場合で処理を分ける

```python
# 基本
def bit_search(n):
    li = range(n + 1)
    for i in range(2 ** n):
        ref = []
        for j in range(n):
            if (i >> j) & 1:
                ref.append(li[j])
        yield tuple(ref)
# ()
# (0,)
# (1,)
# (0, 1)
# (2,)
# (0, 2)
# (1, 2)
# (0, 1, 2)
```

```python
# 応用
def bit_search(n):
    li = range(n + 1)
    for i in range(2 ** n):
        ref = []
        for j in range(n):
            if (i >> j) & 1:
                ref.append("+")
            else:
                ref.append("")
        yield tuple(ref)
# ('', '')
# ('+', '')
# ('', '+')
# ('+', '+')
```

## pythonでのビット全探索

pythonではビット全探索を使わずとも同じ処理を行うことが可能。

### 1. フラグが立っていたら何かをする

繰り返しになるが、ビット全探索(基本)は以下のような二次元配列をループする。

```bash
()
(0,)
(1,)
(0, 1)
(2,)
(0, 2)
(1, 2)
(0, 1, 2)
```

- 何も選ばない`()`
- 1つ選ぶ(`(1)`他)
- 2つ選ぶ(`(0, 2)`他)
- 3つ選ぶ`(0, 1, 2)`

これは`itertools.combinations`で書くことが可能。以下の2つは同じ動作をする。

```python
def bit_search(n):
    li = range(n + 1)
    for i in range(2 ** n):
        ref = []
        for j in range(n):
            if (i >> j) & 1:
                ref.append(li[j])
        yield tuple(ref)

from itertools import combinations

def comb_search(n):
    for i in range(n + 1):
        for t in combinations(range(n), i):
            yield t
```

しかも後者のほうが20倍ほど速い。

```bash
bit:
    0.117498 sec
comb:
    0.005236 sec
relative:
    comb:
        1
    bit:
        22.44
```

### 2. フラグが立っている場合と立っていない場合で処理を分ける

itertools.productが使える。以下の2つは同じ動作をする。

```python
def bit_search(n):
    li = range(n + 1)
    for i in range(2 ** n):
        ref = []
        for j in range(n):
            if (i >> j) & 1:
                ref.append("+")
            else:
                ref.append("")
        yield tuple(ref)


from itertools import product

def product_search(n):
    for t in product(["+", ""], repeat=n):
        yield t
```

そしてやはり後者のほうが速い。

```bash
bit:
    0.002234 sec
pro:
    0.000089 sec
relative:
    pro:
        1
    bit:
        25.15
```

## まとめ

```python
from itertools import combinations

def comb_search(n):
    for i in range(n + 1):
        for t in combinations(range(n), i):
            yield t
```

```python
from itertools import product

def product_search(n):
    for t in product(["+", ""], repeat=n):
        yield t
```

pythonでは上記２つの関数がビット全探索の代替になる。以下の問題は全てこの関数で解くことができる。

- [C - To 3 (274)](https://atcoder.jp/contests/abc182/tasks/abc182_c)
- [C - Train Ticket (331)](https://atcoder.jp/contests/abc079/tasks/abc079_c)
- [C - Bowls and Dishes (472)](https://atcoder.jp/contests/abc190/tasks/abc190_c)
- [C - Skill Up (595)](https://atcoder.jp/contests/abc167/tasks/abc167_c)
- [C - H and V (653)](https://atcoder.jp/contests/abc173/tasks/abc173_c)
- [C - Switches (805)](https://atcoder.jp/contests/abc128/tasks/abc128_c)
- [C - ORXOR (809)](https://atcoder.jp/contests/abc197/tasks/abc197_c)
- [C - HonestOrUnkind2 (977)](https://atcoder.jp/contests/abc147/tasks/abc147_c)
- [C - たくさんの数式 (1089)](https://atcoder.jp/contests/abc045/tasks/arc061_a)
- [C - Shopping Street (1130)](https://atcoder.jp/contests/abc080/tasks/abc080_c)
- [C - All Green (1393)](https://atcoder.jp/contests/abc104/tasks/abc104_c)
- [D - 派閥 (1418)](https://atcoder.jp/contests/abc002/tasks/abc002_4)

> ちなみに、再帰関数を使った方が速い場合もあります
