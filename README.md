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

## 📦 セットアップ

### 1. リポジトリを clone

```bash
git clone git@github.com:Tomoe-Yoko/task_app.git
cd task_app
