# pytest-mockの使い方

## install

```bash
# pip
pip install pytest-mock
# poetry
poetry add pytest-mock -D
```

## print関数のtest

print関数は引数に渡したものを標準出力に表示する機能がある。

関数`fn`を定義してその中でprint関数を使っているとする。これをtestする方法として`stdout`を監視する方法を考えてみる。しかしこれはprint関数のtestも行っていることになる。

`引数に与えた数を二乗して出力する`関数`fn`を定義して、この関数をtestすることを考える。

```python
def fn(n):
    print(n ** 2)
```

このtestを行う方法は大きく2種類考えられる

1. 標準出力に出力されているかを確認する
2. print関数が期待される引数で呼ばれているかを確認する

[テストダブル](https://www.wikiwand.com/ja/%E3%83%86%E3%82%B9%E3%83%88%E3%83%80%E3%83%96%E3%83%AB)を知らないと`1`を考えてしまいそうだが「標準出力に出力されているかを確認する」というのはprint関数のtestを兼ねてしまっている。print関数は当然正しく動作しているならば`2`の「print関数が期待される引数で呼ばれているかを確認する」だけで十分。これをtestするのがmockである。

> mockについて
> mockとスタブの違いやtest用のmockと開発用のmockの違いを考えるとわけがわからなくなる。
> ここではmock=代用品として解説する

print関数を代用品(=mock)と差し替えて、「print関数が期待される引数で呼ばれているかを確認する」方法をpytestを使った例を以下に示す。

```python
def fn(n):
    print(n ** 2)


def test_mock(mocker):
    mocker.patch("builtins.print") # printをmockに差し替える
    print.assert_not_called()  # この時点でprintは呼ばれていない
    fn(3)
    print.assert_any_call(9)  # print(9)で呼ばれた
    print.assert_called()  # mockが呼ばれた
    print.assert_called_once()  # mockが１回呼ばれた
    print.assert_called_once_with(9)  # mockが１回print(9)で呼ばれた
    print.assert_has_calls([mocker.call(9)])
    print.assert_called_with(9)
    assert print.called == True
    assert print.call_args == mocker.call(9)
    assert print.call_args_list == [mocker.call(9)]
    assert print.call_count == 1
    assert print.called == True

    fn(8)
    print.assert_any_call(9)
    print.assert_any_call(64)
    print.assert_has_calls([mocker.call(9))
    print.assert_has_calls([mocker.call(9), mocker.call(64)])
    assert print.call_args == mocker.call(64)
    assert print.call_args_list == [mocker.call(9), mocker.call(64)]
    assert print.call_count == 2
```

`pytest-mock`は`unittest.mock`のラッパーなので、assert関数についてはunittestを参照すると良い。

[unittest.mock --- モックオブジェクトライブラリ — Python ドキュメント](https://docs.python.org/ja/3/library/unittest.mock.html)

| 関数                    | 機能                             |
|:------------------------|:--------------------------------|
| assert_called           | モックが少なくとも一度は呼び出されたことをassert |
| assert_called_once      | モックが一度だけ呼び出されたことをassert      |
| assert_called_with      | 特定の引数で呼ばれたことをassert         |
| assert_called_once_with | 特定の引数で一度だけ呼ばれたことをassert   |
| assert_any_call         | 特定の引数で呼び出されたことがあるのをassert  |
| assert_has_calls        | 特定の呼び出しで呼ばれたことをassert       |
| assert_not_called       | 呼ばれなかったことをassert                |
| reset_mock              | 呼び出された履歴をreset               |
| call_args               | 最後に呼ばれた時の引数                |
| call_args_list          | 呼出履歴の引数list                |

## classのtest

```python
class AAA:
    def __init__(self, name) -> None:
        self.name = name

    def bbb(self, age):
        return f"{self.name} is age {age}"


def test_class_instance(mocker):
    mock = mocker.patch.object(AAA, "__init__", return_value=None)
    ins = AAA("alice")
    mock.assert_called_with("alice")


def test_class_method(mocker):
    mock = mocker.patch.object(AAA, "bbb", return_value=None)
    ins = AAA("alice").bbb(3)
    mock.assert_called_with(3)
```

後者の場合、insはmockではなくAAAのインスタンスになる。
