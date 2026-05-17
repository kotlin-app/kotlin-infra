# Kubernetes マニフェスト

## 適用順序

```bash
kubectl apply -f namespace/
kubectl apply -f postgres/
kubectl apply -f redis/
kubectl apply -f kafka/
kubectl apply -f product-service/
kubectl apply -f review-service/
kubectl apply -f order-service/
kubectl apply -f bff-app/
kubectl apply -f frontend/
kubectl apply -f monitoring/
```

## 一括適用

```bash
kubectl apply -R -f .
```

## 確認

```bash
kubectl get all -n kotori-market
```

## NodePort アクセス先

| サービス | URL |
|---------|-----|
| フロントエンド | http://localhost:30090 |
| Grafana | http://localhost:30300 (admin/admin) |
