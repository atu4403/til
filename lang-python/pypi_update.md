# pypiにpublishする時の手順書

## 前提条件

- localでの開発が終わり、testも通っている
- main以外のブランチを切って作業している

## 手順(概要)

1. GitHubにpushしてCIが通るか確認
2. pyproject.tomlのバージョンを上げる
3. poetry publish --build
4. pyproject.tomlに変更があるのでcommit & push
5. tagを付けてpush

## 手順(コマンド)

### 1. GitHubにpushしてCIが通るか確認

```bash
git push origin <ブランチ名>
```

### 2. pyproject.tomlのバージョンを上げる

```bash
# バグ修正等
poetry version patch
# 新機能追加等
poetry version minor
# 破壊的変更を含む場合
poetry version major
```

### 3. poetry publish --build

```bash
poetry publish --build
```

### 4. pyproject.tomlに変更があるのでcommit & push

```bash
git add pyproject.toml
git commit
git checkout main
git merge <ブランチ名>
```

### 5. tagを付けてpush

```bash
git tag v0.1.0 # 最新のコミットに対してtagを作成
git push origin --tags
```
