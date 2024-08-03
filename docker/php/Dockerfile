FROM php:8.2-fpm

# 必要なパッケージをインストールし、PHP拡張機能をインストール
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    make \
    nano \
    vim \
    sudo \
    && docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd mysqli

#Composer インストール
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php composer-setup.php
RUN php -r "unlink('composer-setup.php');"
RUN mv composer.phar /usr/local/bin/composer

ENV COMPOSER_ALLOW_SUPERUSER 1

ENV COMPOSER_HOME /composer

ENV PATH $PATH:/composer/vendor/bin

#Node.jsのインストール
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
RUN apt-get install -y nodejs

# 設定ファイルのコピー
COPY /docker/php/php.ini /usr/local/etc/php/

# Laravelインストーラーのインストール
RUN composer global require "laravel/installer"

# # Composerの依存関係をインストール（
# RUN cd /var/www/html/src && if [ -f /var/www/html/src/composer.json ]; then composer install --no-scripts; else echo "composer install skip"; fi

# # Composerの依存関係を再インストール（スクリプトを有効化）
# RUN cd /var/www/html/src && if [ -f composer.json ]; then composer install; else echo "composer install skip"; fi

# # Npmの依存関係をインストール
# RUN cd /var/www/html/src && if [ -f /var/www/html/src/package.json ]; then npm install; else echo "npm install skip"; fi

# 作業ディレクトリを設定
WORKDIR /var/www/html/

# laravelインストール後にコメントアウト
# RUN npm install
