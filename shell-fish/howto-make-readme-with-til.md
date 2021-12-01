# TILのREADMEを自動作成するfish scriptを書いた

```bash
function make_readme
    set til_dir /Users/atu/ghq/github.com/atu4403/til
    cd $til_dir
    echo "# til

til - Today I learned.

## 環境

macos

## contents"
    for child in (ls)
        if test -d $child
            echo -e "\n### $child\n"
            for file in (ls $child)
                if test (echo $file| sed 's/^.*\.\([^\.]*\)$/\1/') = md
                    set txt (cat $til_dir/$child/$file)
                    set title (echo (string replace '# ' '' $txt[1]))
                    echo '- '\[$title\]\($child/$file\)
                end
            end
        end
    end
end
make_readme >README.md
```

- これを`make_readme.fish`というファイル名で`README.md`と同じディレクトリに保存
- `fish make_readme.fish`で自動作成完了

## コード解説

インデントがおかしくなっている箇所がありますが間違いではないです。fishのダブルクオーテーションは改行を反映してくれるのでこのようになっています。

```bash
    echo "# til

til - Today I learned.

## 環境

macos

## contents"
```

ディレクトリ構造は以下のようになっています。`cli`や`shortcut`等で分類の為にディレクトリを作り、その下に`md`ファイルが入っています。

```bash
.
├── bugs
│   └── fish-bugs.md
├── cli
│   ├── gh.md
│   └── ghq.md
├── cli-git
│   ├── about.md
│   ├── howto-git_log_case_01.md
│   └── log.md
├── editor-vscode
│   └── awasome_extentions_2021.md
├── shell-fish
│   ├── about.md
│   ├── devnull.md
│   └── set.md
├── shortcut
│   ├── fish.md
│   └── vscode.md
├── README.md
├── make_readme.fish
└── todo.md
```

- 第１階層がディレクトリなら、そこには記事が入っているのでforで回します
- 第２階層の拡張子が`md`なら、そのファイルを開いて1行目を取り出します
- 1行目は必ず'# 'で始まっているのでそれを削除し、markdownのリンクに整形します

最後に、`README.md`にリダイレクトして完了。

## コミット時に自動で実行されるようにする

```bash
echo 'fish make_readme.fish' >.git/hooks/post-commit
chmod +x .git/hooks/post-commit
```

## 感想

こういう処理はpythonでもnodejsでも書けるけど助長になりがちです。シェルスクリプトで書いたほうが良いのはわかるけど`if〜fi`とか`[ "$((var))" -eq 123 ]`が理解しづらく敬遠していました。

fishなら`for`も`if`も`end`で閉じるし構文が理解しやすいように感じます。
