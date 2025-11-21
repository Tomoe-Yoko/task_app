# TaskApp

万葉 Ruby on Rails トレーニング用のタスク管理アプリです。

## 🌱 概要
このアプリケーションは、Rails と Tailwind CSS、PostgreSQL を用いたタスク管理システムです。  
以下の要件に沿って開発を進めています。

- タスクの登録・編集・削除
- 期限の設定
- 優先度の設定
- ステータス管理（未着手 / 着手 / 完了）
- タスク一覧のソート・検索
- ラベル付け機能（任意）

## 🛠 使用技術

| 種類 | バージョン |
|------|------------|
| Ruby | 3.4.7 |
| Rails | 7.1.6 |
| DB | PostgreSQL 18 |
| CSS | Tailwind CSS |
| Linter | Rubocop + GitHub Actions |


## データベーススキーマ
### users テーブル

| カラム名 | 型 | 制約 | 説明 |
|---------|----|---------------------|----------------|
| id | bigint | PK | ユーザーID |
| name | string | NOT NULL | ユーザー名 |
| email | string | NOT NULL, UNIQUE | メールアドレス |
| created_at | datetime | NOT NULL | 作成日時 |
| updated_at | datetime | NOT NULL | 更新日時 |

---

### tasks テーブル

| カラム名 | 型 | 制約 | 説明 |
|----------|--------|-----------------------------|----------------|
| id | bigint | PK | タスクID |
| user_id | bigint | FK（users.id）, NOT NULL | 所有ユーザー |
| title | string | NOT NULL | タスクタイトル |
| content | text | | タスク内容 |
| deadline | datetime | | 期日 |
| priority | integer | NOT NULL（enum） | 優先度（low/medium/high） |
| status | integer | NOT NULL（enum） | ステータス（not_started/doing/done） |
| label_id | bigint | FK（labels.id） | 紐付くラベル |
| created_at | datetime | NOT NULL | 作成日時 |
| updated_at | datetime | NOT NULL | 更新日時 |

---

### labels テーブル

| カラム名 | 型 | 制約 | 説明 |
|----------|--------|------------------------------|----------------|
| id | bigint | PK | ラベルID |
| user_id | bigint | FK（users.id）, NOT NULL | ラベル作成ユーザー |
| name | string | NOT NULL | ラベル名 |
| created_at | datetime | NOT NULL | 作成日時 |
| updated_at | datetime | NOT NULL | 更新日時 |

---

## enum 定義

### priority（優先度）

| 名称 | 値 |
|------|----|
| low | 0 |
| medium | 1 |
| high | 2 |

### status（ステータス）

| 名称 | 値 |
|------|----|
| not_started | 0 |
| doing | 1 |
| done | 2 |

---

## リレーション

- User（1）—（n）Tasks  
- User（1）—（n）Labels  
- Label（1）—（n）Tasks  
  - ※タスクは 1 つのラベルのみ保持




## 📦 セットアップ

### 1. リポジトリを clone

```bash
git clone git@github.com:Tomoe-Yoko/task_app.git
cd task_app
