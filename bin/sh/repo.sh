# コンテナをビルドして起動
docker-compose -f docker-compose.init.yml up -d --build

# composer install
echo "Running composer install..."
docker-compose exec -T app bash -c "if [ -f composer.json ]; then composer install; fi"

# npm install
echo "Running npm install..."
docker-compose exec -T app bash -c "if [ -f package.json ]; then npm install; fi"

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
