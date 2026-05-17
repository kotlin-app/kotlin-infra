# ArgoCD GitOps セットアップ

## 1. ArgoCD インストール

```bash
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

## 2. ArgoCD UI へのアクセス

```bash
# ポートフォワード
kubectl port-forward svc/argocd-server -n argocd 8443:443

# 初期パスワード取得
kubectl -n argocd get secret argocd-initial-admin-secret \
  -o jsonpath="{.data.password}" | base64 -d && echo
```

ブラウザで `https://localhost:8443` にアクセス（admin / 上記パスワード）

## 3. ArgoCD CLI でログイン

```bash
argocd login localhost:8443 --insecure --username admin --password <パスワード>
```

## 4. AppProject と Application の適用

```bash
# プロジェクト作成
kubectl apply -f argocd/project.yaml

# Application 作成（GitOps 同期開始）
kubectl apply -f argocd/application.yaml
```

## 5. 同期確認

```bash
# CLI で確認
argocd app get kotori-market
argocd app sync kotori-market

# 手動同期（自動同期が有効なので通常不要）
argocd app sync kotori-market --force
```

## 6. GitOps ワークフロー

```
開発者が values.yaml または Helm テンプレートを変更
    ↓
git push → kotlin-infra main ブランチ
    ↓
ArgoCD が変更を検知（デフォルト 3 分ポーリング）
    ↓
Kubernetes クラスターへ自動デプロイ（prune + selfHeal 有効）
```

## 7. イメージタグの更新例

```bash
# values.yaml を更新してプッシュ
sed -i 's/tag: latest/tag: v1.2.0/' helm/kotori-market/values.yaml
git add helm/kotori-market/values.yaml
git commit -m "chore: bump product-service to v1.2.0"
git push
# ArgoCD が自動的に新しいイメージをデプロイ
```
