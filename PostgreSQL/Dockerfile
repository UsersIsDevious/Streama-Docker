# OpenJDK 8 の軽量 Alpine イメージをベースに使用
FROM openjdk:8-jre-alpine

# 作業ディレクトリの作成
WORKDIR /app

# 必要なツール (curl) のインストール
RUN apk add --no-cache curl

# 使用する Streama のバージョンを指定
ENV STREAMA_VERSION=1.10.5

# GitHub のリリースから Streama の jar ファイルをダウンロード
RUN curl -L -o streama.jar https://github.com/streamaserver/streama/releases/download/v${STREAMA_VERSION}/streama-${STREAMA_VERSION}.jar

# コンテナの 8080 番ポートを公開
EXPOSE 8080

# コンテナ起動時に Streama を実行
CMD ["java", "-jar", "streama.jar"]
