# ベースイメージとして OpenJDK 8 の軽量Alpine版を使用
FROM openjdk:8-jre-alpine

# 作業ディレクトリを作成
WORKDIR /app

# 必要なツール（curl）をインストール
RUN apk add --no-cache curl

# Streama のバージョンを環境変数で指定
ENV STREAMA_VERSION=1.9.0

# GitHubのリリースからStreamaのjarファイルをダウンロード
RUN curl -L -o streama.jar https://github.com/streamaserver/streama/releases/download/v${STREAMA_VERSION}/streama-${STREAMA_VERSION}.jar

# コンテナの8080番ポートを公開
EXPOSE 8080

# コンテナ起動時に Streama を実行
CMD ["java", "-jar", "streama.jar"]
