# my functions

fishのオリジナル関数。

## words

英単語のスペルがうろ覚えの時に辞書から探してコピーする

```bash
function words
    cat /usr/share/dict/words | fzf| pbcopy
end
```

## names

適当な名前が欲しい時に探してコピーする

```bash
function names
    cat /usr/share/dict/propernames | fzf| pbcopy
end
```
