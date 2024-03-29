# poetryでpypiにpublishする時の手順書

## 前提条件

- localでの開発が終わり、testも通っている
- main以外のブランチを切って作業している
- GitHubFlowで運用している
- pre-commitでmainへのcommitを禁止している
- 手順が多いので自動化させたい

### GitHubFlowのメリット

- localにmainブランチがいらない
  - 開発時はorigin/mainからcheckoutすることでmainは不要
  - なのでgit pullも不要
- mainへの誤コミットがなくなる

## 大まかな手順

1. pr作成
1. prをmergeしてreleaseとpublish

## 詳細な手順

### pr作成

[fish_conf/poetry_pre_publish.fish at main · atu4403/fish_conf](https://github.com/atu4403/fish_conf/blob/main/functions/poetry_pre_publish.fish)

1. release用のブランチを切ってcheckout
2. `git pull --rebase origin main`
3. バージョンを上げる(major/minor/patch)
4. `poetry build`
5. 一時的にtag付け
6. CHANGELOGを作成
7. tagを削除
8. エディタを開いてCHANGELOGの確認と修正
9. ここまでの変更をcommit & push
10. prの作成
11. prを見てファイルの更新を確認
12. prを見てバージョンが間違いないか確認
13. prを見てCHANGELOGが間違いないか確認
14. CIが通るか確認

解説

- tagを一時的に付けているのはCHANGELOG作成に必要だから
- 失敗した時はprをcloseしてrelease用ブランチを削除する

```bash
gh pr close -d release_poetry
```

### prをmergeしてreleaseとpublish

[fish_conf/poetry_pr_merge.fish at main · atu4403/fish_conf](https://github.com/atu4403/fish_conf/blob/main/functions/poetry_pr_merge.fish)

1. prをmerge
2. `origin/main`から次の開発用のブランチにcheckout
3. `git fetch --prune`
4. GItHUbにreleaseを作成
5. `poetry publish`

解説

- pr mergeと共に不要なブランチは削除され、fetchと共にlocalの不要なブランチは削除される
- release作成と共にtagも付けられる
