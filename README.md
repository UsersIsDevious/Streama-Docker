# Streama Docker コンテナ

このリポジトリは、[Streama](https://docs.streama-project.com/) を Docker 上で簡単に実行するための設定ファイル群を提供します。

## 特徴

- **シンプルな構成**: 最小限の設定で Streama を実行可能
- **軽量ベースイメージ**: `openjdk:8-jre-alpine` を利用してイメージサイズを抑制
- **ローカルディレクトリのマウント**: ホスト側のディレクトリをコンテナ内にマウントし、Streama でアクセス可能
- **柔軟なカスタマイズ**: Dockerfile や docker-compose.yml を用途に合わせて変更可能

## 必要条件

- Docker (v20.10.0 以降を推奨)
- docker-compose (オプション)

## 使用方法

### 1. Dockerイメージのビルド

リポジトリ直下にある `Dockerfile` を利用して、以下のコマンドで Docker イメージをビルドします。

```bash
docker build -t streama .
```

### 2. Dockerコンテナの実行

ホストのディレクトリ（例: `/path/to/your/local/folder`）をコンテナ内の `/app/data` にマウントして実行する場合、以下のようにします。

```bash
docker run -d -p 8080:8080 -v /path/to/your/local/folder:/app/data streama
```

- `-p 8080:8080`：ホストのポート 8080 とコンテナのポート 8080 を接続
- `-v /path/to/your/local/folder:/app/data`：ホストディレクトリをコンテナ内の `/app/data` にマウント

### 3. docker-compose を利用する場合

複数のサービス管理や設定の簡略化のために、docker-compose を利用することもできます。以下は例です。

```yaml
version: '3.8'
services:
  streama:
    build: .
    ports:
      - "8080:8080"
    volumes:
      - /path/to/your/local/folder:/app/data
    environment:
      # 必要に応じて Java オプションなどを設定
      - JAVA_OPTS=-Xmx512m
```

コンテナをバックグラウンドで起動するには、以下のコマンドを実行します。

```bash
docker-compose up -d
```

### 4. ブラウザからのアクセス

コンテナが正常に起動したら、ブラウザで `http://localhost:8080` にアクセスして Streama の初期設定画面を確認してください。

## Streama のバージョン

この Dockerfile では、デフォルトで Streama バージョン `v1.10.5` を使用しています。必要に応じて、`Dockerfile` 内の環境変数 `STREAMA_VERSION` を変更してください。  
最新のリリースは [公式GitHubリリースページ](https://github.com/streamaserver/streama/releases) をご確認ください。

## 注意事項

- **データベースについて**: 本コンテナは組み込みの H2 データベースを使用しています。運用環境では、MySQL や PostgreSQL 等の外部データベースの利用を検討してください。
- **パーミッション設定**: マウントするホスト側のディレクトリへのアクセス権限が適切に設定されているか確認してください。
- **カスタマイズ**: 必要に応じて Dockerfile や docker-compose.yml を変更し、環境に合わせた設定を行ってください。

## ライセンス

このプロジェクトは [MIT License](LICENSE) の下でライセンスされています。


---
