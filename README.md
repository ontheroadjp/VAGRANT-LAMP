# VAGRANT-LAMP

## 説明

* Vagrant で動くスタンダードな LAMP 環境

## 使い方

```
$ mkdir ~/workspace
$ cd ~/workspace
$ git clone https://github.com/ontheroadjp/VAGRANT-LAMP.git
$ cd VAGRANT-LAMP
$ vagrant up
```

## 構築される環境

### サーバー環境

* Linux（Ubuntu）
* Apache2
* MySQL 5.5
* PHP5

### ツール関連

* phpMyAdmin
* git
* Vim
* unzip
* curl

など

### その他

* WordPress(日本語最新版)

## WEB サーバー（Apache2）

URL: localhost  
ポート番号: 8080
ドキュメントルート /var/www  

※ /var/www は VAGRANT-LAMP/www と共有

## データベース（MySQL 5.5）

ユーザー名: root  
パスワード: PASSWORD

## SSH

接続

```
vagrant ssh
```

ポート番号： 2222

