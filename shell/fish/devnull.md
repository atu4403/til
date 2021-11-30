# /dev/nullについて

## 標準出力を破棄

```bash
>/dev/null
1>/dev/null
```

## 標準エラー出力を破棄

```bash
2>/dev/null
```

## 共に出力を破棄

```bash
>/dev/null 2>&1
>/dev/null 2>/dev/null
```

## わかったこと

- `>`は「標準出力をリダイレクト」なので、`>`と`1>`は同義
- fishのエラー出力へのリダイレクトは`^`が使えるが、`2>`も使える

## わかりやすい解説

- [Linux - >/dev/null 2>&1 の順番・意味について｜teratail](https://teratail.com/questions/138861)

## 確認コード

## bash, zsh

```zsh
function out_error() {
    echo 標準出力
    echo 標準エラー出力 >&2
}
```

## fish

```bash
function out_error
    echo 標準出力
    echo 標準エラー出力 >&2
end
```

関数の書き方が違うだけで検証部分のコードは同じ。結果も同じ。

```bash
echo '===== no devnull'
out_error
echo '===== 1>/dev/null'
out_error 1>/dev/null
echo '===== 2>/dev/null'
out_error 2>/dev/null
echo '=====  1>/dev/null 2>/dev/null'
out_error >/dev/null 2>/dev/null
echo '=====  >/dev/null 2>&1'
out_error >/dev/null 2>&1
```

```bash
===== no devnull
標準出力
標準エラー出力
===== 1>/dev/null
標準エラー出力
===== 2>/dev/null
標準出力
=====  1>/dev/null 2>/dev/null
=====  >/dev/null 2>&1
```
