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
            if test $child = images
                continue
            end
            echo -e "\n### $child\n"
            for file in (ls $child)
                if test (echo $file| sed 's/^.*\.\([^\.]*\)$/\1/') = md
                    set txt (cat $til_dir/$child/$file)
                    set title (echo (string replace '# ' '' $txt[1]))
                    if test $title = WIP
                        continue
                    end
                    echo '- '\[$title\]\($child/$file\)
                end
            end
        end
    end
end
make_readme >README.md
