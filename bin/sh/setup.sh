# コンテナを起動
docker-compose up -d --build
# 成功後コンテナに入る
docker-compose exec app bash

# 一時ディレクトリを作成
mkdir ../temp

# Makefileなど、保持したいファイルを一階層上の一時ディレクトリに移動
mv * ../temp/ 2>/dev/null
mv .* ../temp/ 2>/dev/null

# Laravelをインストール
composer create-project laravel/laravel .

# 一階層上に移動
cd ..

# 一時的に移動したファイルを元のディレクトリに戻す
mv temp/* html/ 2>/dev/null
mv temp/.* html/ 2>/dev/null

# 一時ディレクトリを削除
rmdir temp

# プロジェクトディレクトリに戻る
cd html

# パッケージなどをインストール
composer install
npm install

# keyを生成する
php artisan key:generate

# 抜ける
exit

# ルートディレクトリの.envを一時ファイルにコピー
cat .env > src/.env.tmp
# Laravelの.envを一時ファイルの末尾に追加
cat ./src/.env >> src/.env.tmp
# 一時ファイルをLaravelの.envにコピー
copy src/.env.tmp src/.env
# 一時ファイルを削除
rm src/.env.tmp

# 再度コンテナにはいる
docker-compose exec app bash

#マイグレーションを実行
php artisan migrate

#以下権限設定
#ubuntu debianOSの場合
chown -R www-data:www-data /var/www/html
# ディレクトリを755に設定
find . -type d -exec chmod 755 {} \;

# ファイルを644に設定
find . -type f -exec chmod 644 {} \;

# storage と bootstrap/cache を書き込み可能に設定
chmod -R 775 ./storage
chmod -R 775 ./bootstrap/cache

#artisanに実行権限
chmod 755 artisan