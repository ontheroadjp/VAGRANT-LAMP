# VAGRANT-LAMP

## Description

* Vagrant で動くスタンダードな LAMP 環境

## Require

1. [Vagrant](https://www.vagrantup.com/) 
2. [VirtualBox](https://www.virtualbox.org/wiki/Downloads) 

## Getting start



```bash
# インストールディレクトリ作成 & 移動
$ mkdir ~/workspace && cd ~/workspace

# Git クローン
$ git clone https://github.com/ontheroadjp/VAGRANT-LAMP.git

# 起動
$ cd VAGRANT-LAMP
$ vagrant up
```

## Environment

### LAMP

* Ubuntu 12.04(32 bit)　※Vagrant BOX: precise32
* Apache 2.2.22
* MySQL 5.5.46
* PHP 5.3.10

### Tools

* phpMyAdmin
* git 1.7.9.5
* Vim 7.3.439

e.t.c.

### Applications

* WordPress( Latest - Japanese )

## WEB server（Apache 2.2.22）

* ブラウザでアクセスする ``http://localhost:8080``
* ドキュメントルート ``/var/www``

※ ``/var/www`` は ``VAGRANT-LAMP/www`` と共有

## Database（MySQL 5.5.46）

ユーザー名： ``root``  
パスワード： ``PASSWORD``  
文字セット： ``UTF-8``

```bash
$ mysql -u root -pPASSWORD
```

## phpMyAdmin

* ブラウザでアクセスする ``http://localhost:8080/phpmyadmin/``

ユーザー名: root  
パスワード: PASSWORD

## WordPress

* ブラウザでアクセスする ``http://localhost:8080/wordpress/``
* 管理画面ログイン
	* ユーザー名： ``root``
	* パスワード： 初回アクセス時に設定
* DB 名： ``wordpress``
* DB のユーザー名： ``wordpress``
* DB のパスワード： ``wordpress_passwd``

## SSH

ホストOS からの接続

```bash
$ vagrant ssh
```

ポート番号： 2222

