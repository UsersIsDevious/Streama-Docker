# Streama + PostgreSQL Docker セットアップ

このリポジトリは、[Streama](https://streama-project.com/) アプリケーションを PostgreSQL データベースと連携させ、Docker 上で実行するための設定ファイル群を提供します。

## 構成

- **streama**  
  - OpenJDK ベースのコンテナで Streama を実行します。  
  - 環境変数により PostgreSQL 接続情報を設定しています。  
  - ホスト側のディレクトリをコンテナ内の `/app/data` にマウント可能です。

- **postgres**  
  - 公式 PostgreSQL イメージ（例: `postgres:13`）を利用します。  
  - データ永続化のため、Docker ボリューム `pgdata` を使用しています。

## 必要条件

- Docker (v20.10.0 以降推奨)
- docker-compose

## 使用方法

### 1. リポジトリのクローン

まず、このリポジトリをローカルにクローンしてください。

```bash
git clone <リポジトリのURL>
cd <クローンしたディレクトリ>
```

### 2. Docker イメージのビルド

リポジトリ内の `Dockerfile` を利用して、Streama イメージをビルドします。

```bash
docker-compose build
```

### 3. コンテナの起動

以下のコマンドで、バックグラウンド実行モードでコンテナを起動します。

```bash
docker-compose up -d
```

### 4. 動作確認

ブラウザで `http://localhost:8080` にアクセスし、Streama の初期設定画面が表示されることを確認してください。

## 環境変数

### Streama コンテナ側

- `DATABASE_DRIVER`: `org.postgresql.Driver`
- `DATABASE_URL`: `jdbc:postgresql://postgres:5432/streama`
- `DATABASE_USERNAME`: `streama`
- `DATABASE_PASSWORD`: `streama`
- `JAVA_OPTS`: `-Xmx512m` （必要に応じて変更してください）

### PostgreSQL コンテナ側

- `POSTGRES_DB`: `streama`
- `POSTGRES_USER`: `streama`
- `POSTGRES_PASSWORD`: `streama`

> **注意**  
> 本番環境で使用する際は、データベースの認証情報等を適切な値に変更してください。

## ボリュームマウント

- `docker-compose.yml` 内で、ホスト側の任意のディレクトリ（例: `/path/to/your/local/folder`）をコンテナ内の `/app/data` にマウントしています。  
- 必要に応じてパスを変更してください。

## データ永続化

- PostgreSQL のデータは `pgdata` ボリュームに保存されます。  
- コンテナの再起動時にもデータは保持されるようになっています。

## カスタマイズ

- **Streama バージョン**  
  `Dockerfile` 内の `STREAMA_VERSION` 環境変数で使用する Streama のバージョンを指定しています。  
  最新バージョンを使用する場合は、適宜変更してください。

- **Java オプション**  
  `JAVA_OPTS` でメモリ設定などを変更できます。

## トラブルシューティング

- コンテナのログを確認するには、以下のコマンドを使用してください。

  ```bash
  docker-compose logs -f
  ```

- 接続エラーなどが発生した場合は、各コンテナの環境変数やネットワーク設定、ボリュームマウントのパスを再確認してください。

## ライセンス

このプロジェクトは [MIT License](LICENSE) の下でライセンスされています。
