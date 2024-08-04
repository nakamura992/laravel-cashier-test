@echo off
setlocal enabledelayedexpansion

REM コンテナをビルドして起動
echo Building and starting containers...
docker-compose -f docker-compose.init.yml up -d --build

REM composer install
echo Running composer install...
docker-compose exec -T app bash -c "if [ -f composer.json ]; then composer install; fi"

REM npm install
echo Running npm install...
docker-compose exec -T app bash -c "if [ -f package.json ]; then npm install; fi"

REM コンテナを削除
echo Stopping and removing containers...
docker-compose down

REM コンテナを通常通りのymlでビルド
echo Building and starting containers with standard yml...
docker-compose up -d --build

REM ホストのvendorディレクトリをコンテナのappにコピー
echo Copying vendor directory to container...
docker-compose cp ./src/vendor app:/var/www/html

REM ホストのnode_modulesディレクトリをコンテナのappにコピー
echo Copying node_modules directory to container...
docker-compose cp ./src/node_modules app:/var/www/html

REM ホストのstorageディレクトリをコンテナのappにコピー
echo Copying storage directory to container...
docker-compose cp ./src/storage app:/var/www/html

echo Setup completed.