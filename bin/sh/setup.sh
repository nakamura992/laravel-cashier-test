#!/bin/bash
set -e

# コンテナをビルドして起動
docker-compose -f docker-compose.init.yml up -d --build

# コンテナ内での作業
echo "exec command: mkdir ../temp"
docker-compose exec -T app bash -c "mkdir ../temp"

echo "exec command: mv * ../temp/ 2>/dev/null || true"
docker-compose exec -T app bash -c "mv * ../temp/ 2>/dev/null || true"

echo "exec command: mv .* ../temp/ 2>/dev/null || true"
docker-compose exec -T app bash -c "mv .* ../temp/ 2>/dev/null || true"

echo "exec command: composer create-project laravel/laravel ."
docker-compose exec -T app bash -c "composer create-project laravel/laravel ."

echo "exec command: cd .. && mv temp/* html/ 2>/dev/null && mv temp/.* html/ 2>/dev/null && rmdir temp && cd html"
docker-compose exec -T app bash -c "cd .. && mv temp/* html/ 2>/dev/null && mv temp/.* html/ 2>/dev/null && rmdir temp && cd html"

echo "exec command: composer install"
docker-compose exec -T app bash -c "composer install"

echo "exec command: npm install"
docker-compose exec -T app bash -c "npm install"

# .env.exampleから.envを複製
cp src/.env.example src/.env

# ルートディレクトリの.envを一時ファイルにコピー
cp .env src/.env.tmp

# Laravelの.envを一時ファイルの末尾に追加
cat src/.env >> src/.env.tmp

# 一時ファイルをLaravelの.envにコピー
mv src/.env.tmp src/.env

# 再度コンテナ内での作業

# アプリケーションキーを生成
echo "exec command: php artisan key:generate"
docker-compose exec -T app bash -c "php artisan key:generate"

# データベースマイグレーションを実行
echo "exec command: php artisan migrate"
docker-compose exec -T app bash -c "php artisan migrate"

# アプリケーションディレクトリの所有者をwww-dataに変更
echo "exec command: chown -R www-data:www-data /var/www/html"
docker-compose exec -T app bash -c "chown -R www-data:www-data /var/www/html"

# すべてのディレクトリの権限を755に設定
echo "exec command: find . -type d -exec chmod 755 {} \;"
docker-compose exec -T app bash -c "find . -type d -exec chmod 755 {} \;"

# すべてのファイルの権限を644に設定
echo "exec command: find . -type f -exec chmod 644 {} \;"
docker-compose exec -T app bash -c "find . -type f -exec chmod 644 {} \;"

# storageディレクトリの権限を775に設定（書き込み権限を付与）
echo "exec command: chmod -R 775 ./storage"
docker-compose exec -T app bash -c "chmod -R 775 ./storage"

# bootstrap/cacheディレクトリの権限を775に設定（書き込み権限を付与）
echo "exec command: chmod -R 775 ./bootstrap/cache"
docker-compose exec -T app bash -c "chmod -R 775 ./bootstrap/cache"

# artisanファイルの実行権限を設定
echo "exec command: chmod 755 artisan"
docker-compose exec -T app bash -c "chmod 755 artisan"

# publicディレクトリにstorageのシンボリックリンクを作成
echo "exec command: php artisan storage:link"
docker-compose exec -T app bash -c "php artisan storage:link"

# コンテナを削除
echo "exec command: docker-compose down"
docker-compose down

# コンテナを通常通りのymlでビルド
echo "exec command: docker-compose up -d --build"
docker-compose up -d --build

# ホストのvendorディレクトリをコンテナのappにコピー
echo "exec command: docker-compose cp .src/vendor app:/var/www/html"
docker-compose cp ./src/vendor app:/var/www/html

# ホストのnode_modulesディレクトリをコンテナのappにコピー
echo "exec command: docker-compose cp .src/node_modules app:/var/www/html"
docker-compose cp ./src/node_modules app:/var/www/html

# ホストのstorageディレクトリをコンテナのappにコピー
echo "exec command: docker-compose cp .src/storage app:/var/www/html"
docker-compose cp ./src/storage app:/var/www/html

# コピー後にユーザー権限をwww-dataに変更
echo "exec command: chown -R www-data:www-data /var/www/html"
docker-compose exec -T app bash -c "chown -R www-data:www-data /var/www/html"

echo "Setup completed."