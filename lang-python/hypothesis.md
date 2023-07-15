# WIP hypothesis

> Hypothesis は、単体テストを作成するための Python ライブラリです。これは、記述が簡単で、実行するとより強力になり、探すとは思わなかったコード内のエッジ ケースを見つけます。安定しており、強力で、既存のテスト スイートに簡単に追加できます。
> (google先生による訳)

ざっくり言うと、testを行う時の変数を自動で作成してくれるライブラリです。

## 使用例(1)

以下ではpytestを使用しています。

```python
from hypothesis import given, settings, example
import hypothesis.strategies as st


def div(a, b):
    return a / b


def test_div_1():
    assert div(10, 2) == 5
    assert div(10, 4) == 2.5
    assert div(2, 10) == 0.2


@given(st.integers(), st.integers())
def test_div_2(a, b):
    div(a, b)

```

div関数は単純な割り算を行います。`test_div_1`では想定するテストを行なって全て通っています。

`test_div_2`では引数a,bにランダムなint型の値を渡して実行しています。
これにより`想定外の値を渡してもエラーが出ないのか`というtestができます。
結果としてはエラーを吐きます。

```bash
ZeroDivisionError: division by zero
Falsifying example: test_div_2(
    b=0, a=0,
)
```

このように「b=0, a=0」だと落ちるよ、と教えてくれます。

## 使用例(2)

```python
def enc(s):
    if s == "A":
        return 1
    if s == "B":
        return 2
    if s == "C":
        return 3
    return s


def dec(n):
    if n == 1:
        return "A"
    if n == 2:
        return "B"
    return n


@given(st.text())
def test_decode_inverts_encode(s):
    assert dec(enc(s)) == s

```

暗号化を行う関数`enc`と複合化を行う関数`dec`を作ってみました。
ランダムな文字列をencして、そのままdecすると元の文字列に戻ることが期待されます。

しかし、dec関数は`3`が渡されたらそのまま`3`を返してしまいますので以下のような挙動になります。

```python
assert dec(enc("A")) == "A"
assert dec(enc("B")) == "B"
assert dec(enc("C")) == 3
```

つまり`test_decode_inverts_encode`は失敗するはずなのですが、何故か通ってしまいます。

デフォルトでは100回のtestを行なっているのですが、試行回数を増やして再テストしてみましょう。

```python
@settings(max_examples=1000)
@given(st.text())
def test_decode_inverts_encode(s):
    assert dec(enc(s)) == s
```

`max_examples`を指定して回数を1000回に増やしてみましたがやはり通ってしまいます。何故でしょうか。

まず、`@given(st.text())`について解説します。
given関数の引数がそのまま、変数`s`としてtestに渡されています。それでは引数の`st.text()`は何を返しているのか見てみましょう。

```python
@given(st.text())
def test_decode_inverts_encode(s):
    print("s =", s)
    assert dec(enc(s)) == s
```

```bash
s = 𾯜
s = 𾯜)
s = 𾯜㈆
s = 𐥀ª7±aëC󀂮·ª[
s = |
s = i򒍩®
s = ii򒍩®
s = 񇥄Â9
```

`st.text()`により生成される文字列はUTF-8に限らず、文字数もランダムです。このような条件で`C`というケースが出てくるのは1000回程度じゃ難しいので以下の解決方法があります。

- 試行回数をもっと増やす
- テストケースに必ず特定の値を含める
- ストラテジーに条件を設定する

試行回数を増やすことでテストは期待通り失敗します。しかしその分時間もかかるし確実ではないので以下の方法が良いです。

### テストケースに必ず特定の値を含める

```python
@given(st.text())
@example("C")
def test_decode_inverts_encode(s):
    assert dec(enc(s)) == s
```

`@example("C")`とすることで、必ず引数として`"C"`を試しますのでtestは期待通り失敗します。

しかしそもそも、「想定外の値を渡してもエラーが出ないのか」を試すのが肝なので、この方法も現実的ではありません。

### ストラテジーに条件を設定する

`st.text()`は`ii򒍩®`のような文字列も生成するので、これを設定していきたいと思います。

```python
# 公式から引用
hypothesis.strategies.text(
    alphabet=characters(blacklist_categories=('Cs',)),
    *,
    min_size=0,
    max_size=None
    )
```

例えば`st.text("XYZ", min_size=0, max_size=3)`とすると以下のような文字列が生成されます。

```bash
s = 
s = X
s = X
s = XXY
s = XX
s = X
s = Z
s = ZZ
s = Y
```

というわけで、以下の条件によって無事に(?)dec関数のバグを発見できました。

```python
@given(st.text("ABCDE", min_size=0, max_size=3))
def test_decode_inverts_encode(s):
    assert dec(enc(s)) == s
```



```bash
binary: [b'',
 b'\xac\x05\xac\xd5',
 b'-\x1d\x1dy9\x01\x00-',
 b'/\xe5\xe1\x0c\xcfO&\x92l',
 b'',
 b'\xac\x11\xac\xd5',
 b'8\x9b\x9a',
 b'<c\x00j&f\x02<',
 b'\x00\xc9',
 b'\xd6\xd9']
booleans: [False, True, True, False, True, False, False, True, False, True]
characters: ['\x01',
 '\U00089668',
 'Q',
 '\U0008913c',
 'Á',
 '\U00089668',
 '\U000378d3',
 '0',
 '0',
 'X']
complex_numbers: [(1.1+1.1j),
 (-1.1754943508222875e-38+6.61453021552646e+16j),
 (-8.195404167755948e+194-0j),
 (2.2250738585072014e-308-1.3901191102006104e+16j),
 (-2.1153791001076338e+123+2.225073858507203e-309j),
 (nan+infj),
 0j,
 (-inf-infj),
 (1.9+6.8613874036241016e+16j),
 -0j]
dates: [datetime.date(7379, 6, 6),
 datetime.date(918, 5, 27),
 datetime.date(4827, 12, 30),
 datetime.date(1743, 2, 2),
 datetime.date(716, 6, 2),
 datetime.date(458, 7, 28),
 datetime.date(4073, 9, 26),
 datetime.date(707, 6, 29),
 datetime.date(8407, 10, 28),
 datetime.date(4830, 8, 8)]
datetimes: [datetime.datetime(2262, 4, 9, 11, 6, 4, 94606, fold=1),
 datetime.datetime(4493, 10, 9, 1, 17, 8, 593160, fold=1),
 datetime.datetime(2000, 1, 1, 0, 0),
 datetime.datetime(2000, 1, 1, 0, 0),
 datetime.datetime(3066, 11, 14, 13, 4, 42, 197376, fold=1),
 datetime.datetime(196, 4, 6, 21, 23, 58, 630445, fold=1),
 datetime.datetime(6367, 1, 1, 0, 0),
 datetime.datetime(1110, 5, 11, 4, 0, 42, 395989, fold=1),
 datetime.datetime(8408, 2, 13, 9, 0, 13, 327996, fold=1),
 datetime.datetime(1478, 7, 7, 10, 2, 8, 122901)]
decimals: [Decimal('0.3012044404'),
 Decimal('0.07293447'),
 Decimal('-0.10838964'),
 Decimal('-0.0141'),
 Decimal('1.12184381'),
 Decimal('0'),
 Decimal('-0.0141'),
 Decimal('127648.2576'),
 Decimal('1355563125278274360204975344373303080.03960'),
 Decimal('-54071743429504505.62393')]
emails: ['6g@G10.MOE',
 '3PP11@r.CkyEY.h.s.A.COM',
 '!@xvPZDR.eAT',
 '}=@k.o.hoUsE',
 '-mm@W.y.CIBPejCj.p.N.Ac',
 '1{N{l}CoB-{Y@QKF-cIkXjb.x.ZHFIW6.lI7yn.Y.bayern',
 '`2@sAW7H0IP.kIa',
 'Xv|PZh@F.LAnXESs',
 "hs'#RrXN@UwhDkrkOgz.N.UD.WIn",
 '~c@O-G1xYcjbf4GpP.ihBPG0.V.gP0TfWh.BEt']
floats: [inf,
 4.690029808205773e+16,
 -5961017595416068.0,
 -1.1125369292536007e-308,
 -4.319030374672989e+16,
 inf,
 0.0,
 3.976924746929428e+16,
 -3.5846639141595064e+122,
 0.0]
fractions: [Fraction(10389, 113),
 Fraction(9197, 10032),
 Fraction(-2225, 6),
 Fraction(-16, 33),
 Fraction(64, 127),
 Fraction(-3, 53),
 Fraction(-1, 7),
 Fraction(-5281, 24),
 Fraction(3859, 1577385972),
 Fraction(224, 6443)]
functions: [<function <lambda> at 0x103fb7820>,
 <function <lambda> at 0x103f97ca0>,
 <function <lambda> at 0x103f97c10>,
 <function <lambda> at 0x10396ac10>,
 <function <lambda> at 0x103edd550>,
 <function <lambda> at 0x103bdb160>,
 <function <lambda> at 0x103fb71f0>,
 <function <lambda> at 0x10395e3a0>,
 <function <lambda> at 0x10396aca0>,
 <function <lambda> at 0x103fb75e0>]
integers: [-27535, 1609492863, 23079, -121, 26590, -18010, -32160, 0, 0, -37]
ip_addresses: [IPv4Address('192.88.99.251'),
 IPv6Address('2001:23:200:c4ea:da26:778f:51ec:b540'),
 IPv4Address('0.0.0.0'),
 IPv6Address('100::70e6'),
 IPv6Address('64:ff9b::d018'),
 IPv6Address('fd2e:4494:2c62:58f4:fd5f:2e7a:5c35:820f'),
 IPv6Address('2001:10::6a'),
 IPv4Address('192.88.99.125'),
 IPv4Address('192.52.193.255'),
 IPv4Address('240.0.0.0')]
none: [None, None, None, None, None, None, None, None, None, None]
random_module: [RandomSeeder(770),
 RandomSeeder(0),
 RandomSeeder(20043782),
 RandomSeeder(11971),
 RandomSeeder(770),
 RandomSeeder(20043782),
 RandomSeeder(114),
 RandomSeeder(57928),
 RandomSeeder(645133388),
 RandomSeeder(24653)]
randoms: [HypothesisRandom(generated data),
 HypothesisRandom(generated data),
 HypothesisRandom(generated data),
 HypothesisRandom(generated data),
 HypothesisRandom(generated data),
 HypothesisRandom(generated data),
 HypothesisRandom(generated data),
 HypothesisRandom(generated data),
 HypothesisRandom(generated data),
 HypothesisRandom(generated data)]
text: ['\U000e4631',
 '\U000c97bbÊÊd',
 ']\U000e1507',
 'º\x852Û',
 '⾣8\U000cfe52\U00105a39ªâ0',
 '\x1f\x83yc»¸jME\x87¬\x1b\x0cê\U000fd283êÝ',
 'ó噲\x18ÛÀ´$',
 '\U000aff24',
 '\U0004fb07\U000e6f83\U0004f1d0ö',
 '\U000e6a69Øq$']
timedeltas: [datetime.timedelta(days=131318, seconds=322, microseconds=524646),
 datetime.timedelta(days=-456, seconds=456, microseconds=131445),
 datetime.timedelta(days=-512, seconds=65553, microseconds=131309),
 datetime.timedelta(days=84017291, seconds=43, microseconds=919220),
 datetime.timedelta(days=115483393, seconds=57891, microseconds=65800),
 datetime.timedelta(seconds=103, microseconds=103),
 datetime.timedelta(seconds=1025, microseconds=34090),
 datetime.timedelta(days=17247489, seconds=77066, microseconds=77066),
 datetime.timedelta(days=19271681, seconds=75280, microseconds=68385),
 datetime.timedelta(days=1, seconds=65839, microseconds=66428)]
times: [datetime.time(0, 0, 43, 590080, fold=1),
 datetime.time(1, 33, 1, 314996, fold=1),
 datetime.time(14, 9, 14, 327689),
 datetime.time(1, 1, 37, 855553, fold=1),
 datetime.time(1, 33, 15, 131581, fold=1),
 datetime.time(16, 7, 16, 175, fold=1),
 datetime.time(6, 1, 38, 678967),
 datetime.time(14, 1, 9, 65892, fold=1),
 datetime.time(9, 37, 7, 158727),
 datetime.time(0, 14, 14, 196622, fold=1)]
uuids: [UUID('a9622ef0-2577-3ad4-b344-5ecc508de067'),
 UUID('d4697ee5-e4b3-4548-d455-501e74f656f0'),
 UUID('8d350e1b-ea8c-f4c1-211c-a1ee6786f0b3'),
 UUID('baa8d606-f5ae-ba65-f218-6a38882a3f3c'),
 UUID('f584e5a1-7a71-3b39-6b69-84c8f2a9713f'),
 UUID('a457b1ea-4f49-8f55-08d7-63999881f446'),
 UUID('99a031d1-c747-f2ae-5d66-9e76ae9de73c'),
 UUID('07581df2-87dc-ecbe-7f77-2ce9589cd630'),
 UUID('d7a11a9f-dacd-33a7-12ba-cd746a920209'),
 UUID('d61b42f2-570f-017d-b528-3c54b51c183c')]
domains: ['b7A9.UCZfRG.C.xn--MGbCpq6GpA1a',
 'HmCozj5XBz2.T.B1.wOrkS',
 'X.fanS',
 'B0.cOm',
 'A.com',
 'i.E.i.Lt',
 'E.E.xN--jLq480N2RG',
 'B.J.A.cOm',
 'X.n.g.k.vF.X.cOLlegE',
 't.t.t.FOo']
urls: ['https://K1hgHU.b1hgH7.DRiVE:65535/%0C/au%3D9%3C%3DtTf/BC,%3B/-k%5D_Br8q0RqMb/z-C.mhKx%5Cz5dP$L7gAj0y2%3E%0D//X%3F%5B-IIu/%5D%3D/G%5Co%60/4/M/%2F%5B',
 'https://e8j.WIen/Y%3D(MMgNWQX%7BAh8%3C%3FB41r%22n%2072F/UySgJz/)f,%60D%7C0%25%5D%7D4pY/%60ie%3F%0B/Cp4Ie/%2Fk)Zj3',
 'https://J.Ht8pD6NFy5lM8UbMhlLcoF7q0.piNk:46099/#%EC%9E$f%52%93%FF%3A%81',
 'https://OlbefuGfcXDS5R.ONG/',
 "https://Zhl61WgT8.T.nO:13655/J.L932bW/%7D6+g%5Egaq/'y%40%0B%5C/3/%26/_-_VNQ%5D//-$m%7DA./H#N%EF%90%17%C4%A3%1Ej%F2%D2%0Bt",
 "http://B.rXd2paCbWa81CyYD6MSY.gKFW.Ca/,_/nO+p0w(//2%25/e/%3Exb/D*%7D.ff%6048V%0Atvq/$/gAXgJ%23%7BU/./p//FEGeuez%0B/Zy%40Q~O9JX%236W%603/'/j9%5E/%5EKCy/%0C0I%0De%23%5C%5Bj5SK%0B1/'c7Z%5D%5C%3B%60%7Bdad/.%3B'L1%3EP32)Vpm%3D3wP/x%0B/%20f%5BV%3A*ft5%0C#%EC%A1%B5x%A4%19I",
 'https://o.bIz:20737/3d/11040114r5$2%3A#%09%56%C9%DB%CA%F6',
 'http://ta5vs0AGJXvlteQC2Nts.IWqAA.NOw:22001/0(WY/oI4%0D%0C_,A/%3BM5%40%7BD%3A06%7C',
 'http://q.NIssan/%5Df/LN3/%26Ax%26%5B2fG/U%5DdX+/sB%3BI/Q/l%23#%7Bn%F1%B6',
 "https://J.J.VN:1795/+%20r9qrwHUE%60,8dErk7/JJ4lKh'SZ.qy*/$CW%2F%3A2%0A%0D8(%3C-/,#%FD%14"]
```
