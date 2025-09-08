---
name: API機能開発
about: APIの新機能や修正を行う際に使用してください
title: '[API] '
labels: 'api, backend'
assignees: ''

---

## 概要
実装するAPI機能の概要を簡潔に説明してください。

## エンドポイント詳細
### リクエスト
```
Method: GET/POST/PUT/DELETE
URL: /api/v1/xxx
```

### パラメータ
```json
{
  "parameter1": "string",
  "parameter2": "number",
  "parameter3": "boolean"
}
```

### レスポンス
#### 成功時 (200)
```json
{
  "status": "success",
  "data": {
    "id": 1,
    "name": "example"
  }
}
```

#### エラー時 (400/500)
```json
{
  "status": "error",
  "message": "エラーメッセージ",
  "code": "ERROR_CODE"
}
```

## データベース変更
- [ ] 新しいテーブル作成
- [ ] 既存テーブル変更
- [ ] インデックス追加
- [ ] マイグレーション作成

### スキーマ変更（該当する場合）
```sql
-- 必要なスキーマ変更を記載
```

## バリデーション
- [ ] リクエストパラメータの検証
- [ ] 認証・認可の確認
- [ ] データの整合性チェック

## テスト項目
- [ ] 単体テスト作成
- [ ] API統合テスト作成
- [ ] エラーハンドリングテスト
- [ ] パフォーマンステスト

## セキュリティ考慮事項
- [ ] SQLインジェクション対策
- [ ] XSS対策
- [ ] CSRF対策
- [ ] レート制限設定

## 関連Issue
Closes #(issue番号)