# 快速上手

本教程将构建一个基于 `Golang` 的 `Blog` 后端服务，提供标准的 `GRPC API` 以供前端应用调用。在我们开始之前，请确保您的机器上满足了以下前提条件。

## 前提条件

- [Make](setup-make.md)
- [Golang 1.16+](https://golang.org/doc/install)
- [Mysql 8.0+](https://dev.mysql.com/doc/refman/8.0/en/installing.html)
- [cre 0.1.10+](setup-local.md) 
- [Wire](https://github.com/google/wire)
- [gowatch](https://github.com/silenceper/gowatch) (可选)

## 数据字典

设计应用的数据字典 `blog.sql` 如下：

```sql
-- Create a database
CREATE DATABASE  IF NOT EXISTS `blog` ;
USE `blog`;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id comment',
  `parent_id` bigint(20) DEFAULT NULL COMMENT 'parent_id comment',
  `title` varchar(75) NOT NULL COMMENT 'title comment',
  `meta_title` varchar(100) DEFAULT NULL COMMENT 'meta_title comment',
  `slug` varchar(100) NOT NULL COMMENT 'slug comment',
  `content` text COMMENT 'content comment',
  PRIMARY KEY (`id`),
  KEY `idx_category_parent` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


--
-- Table structure for table `post`
--

DROP TABLE IF EXISTS `post`;
CREATE TABLE `post` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `author_id` bigint(20) NOT NULL,
  `title` varchar(75) NOT NULL,
  `meta_title` varchar(100) DEFAULT NULL,
  `slug` varchar(100) NOT NULL,
  `summary` tinytext,
  `published` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `published_at` datetime DEFAULT NULL,
  `content` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_slug` (`slug`),
  KEY `idx_post_user` (`author_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Table structure for table `post_category`
--

DROP TABLE IF EXISTS `post_category`;
CREATE TABLE `post_category` (
  `post_id` bigint(20) NOT NULL,
  `category_id` bigint(20) NOT NULL,
  PRIMARY KEY (`post_id`,`category_id`),
  KEY `idx_pc_category` (`category_id`),
  KEY `idx_pc_post` (`post_id`) /*!80000 INVISIBLE */
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `post_id` bigint(20) NOT NULL,
  `parent_id` bigint(20) DEFAULT NULL,
  `title` varchar(100) NOT NULL,
  `published` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `published_at` datetime DEFAULT NULL,
  `content` text,
  PRIMARY KEY (`id`),
  KEY `idx_comment_post` (`post_id`) /*!80000 INVISIBLE */,
  KEY `idx_comment_parent` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Table structure for table `meta`
--

DROP TABLE IF EXISTS `meta`;
CREATE TABLE `meta` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `post_id` bigint(20) NOT NULL,
  `key` varchar(50) NOT NULL,
  `content` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_meta` (`post_id`,`key`) /*!80000 INVISIBLE */,
  KEY `idx_meta_post` (`post_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Table structure for table `post_tag`
--

DROP TABLE IF EXISTS `post_tag`;
CREATE TABLE `post_tag` (
  `post_id` bigint(20) NOT NULL,
  `tag_id` bigint(20) NOT NULL,
  PRIMARY KEY (`post_id`,`tag_id`),
  KEY `idx_pt_tag` (`tag_id`),
  KEY `idx_pt_post` (`post_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Table structure for table `tag`
--

DROP TABLE IF EXISTS `tag`;
CREATE TABLE `tag` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `title` varchar(75) NOT NULL,
  `meta_title` varchar(100) DEFAULT NULL,
  `slug` varchar(100) NOT NULL,
  `content` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `mobile` varchar(15) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `password_hash` varchar(32) NOT NULL,
  `registered_at` datetime NOT NULL,
  `last_login` datetime DEFAULT NULL,
  `intro` tinytext,
  `profile` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_mobile` (`mobile`),
  UNIQUE KEY `uq_emai` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


```

导入 `Mysql`

```bash
mysql -h <host> -u <user> < blog.sql
```
## 创建项目

以 Linux 下 shell 命令为例

## 生成代码

- 下载 `grpc` 模板

```bash
mkdir -p $HOME/.cre/contrib
git clone https://github.com/ychengcloud/contrib $HOME/.cre/contrib

```

# 创建项目目录

```bash
mkdir todo

cd todo

# 复制模板文件到项目目录
cp -r $HOME/.cre/contrib/grpc/skeleton/* .

## 数据字典
数据字典文件，命名为 schema.sql 置于 database 目录下

```

修改配置文件 `cre.yaml` 内容如下:

```yaml

# 项目名称
project: blog
package: "<package name>"
# 数据库配置
dialect: "mysql"
dsn: "<user>:<password>@tcp(127.0.0.1:3306)/blog?charset=utf8mb4"
# 模板根路径
root: "$HOME/.cre/contrib/grpc/templates"
# 模板生成根路径
genRoot: "./"
    
# 数据表配置
tables:
  - name: "category"
  - name: "post"
    fields:
      - name: "id"
        filterable: true
        operations: ["Eq", "In"]
      - name: "category"
        relation:
          name: "Category"
          type: "manyToMany"
          ref_table: "category"
          join_table:
            name: "post_category"

      - name: "tag"
        relation:
          name: "Tag"
          type: "manyToMany"
          ref_table: "tag"
          join_table:
            name: "post_tag"

      - name: "comment"
        relation:
          name: "Comment"
          type: "hasMany"
          ref_table: "comment"

      - name: "meta"
        relation:
          name: "Meta"
          type: "hasMany"
          ref_table: "meta"

  - name: "comment"
    relation:
      name: "Post"
      type: "BelongsTo"
      ref_table: "post"

  - name: "meta"
    relation:
      name: "Post"
      type: "BelongsTo"
      ref_table: "post"
  
```


- 生成代码

```bash

make gen
make install
make mock
make proto
go mod tidy
go test ./...

```

## 运行前配置

config.default.yaml 为全部可配置项, 默认新建 config.yaml，只需要添加需要覆盖的配置项即可。

配置内容如下：

```yaml
app:
  name: blog
  # 运行模式 1. debug 2. release， 默认 release
  mode: debug
  # 绑定 IP
  host: 127.0.0.1
  # 绑定 Port
  port: 7779

db:
  dialect: mysql
  dsn: "root:@tcp(127.0.0.1:3306)/blog?charset=utf8mb4"
  debug: true
  
logger:
  filename: /tmp/blog.log

```

## 运行

```bash
make run
```

## 体验

需要使用到 grpcurl 工具，详细使用方法请参考 [grpcurl](https://github.com/fullstorydev/grpcurl) 

### 安装 grpcurl
```bash
go install github.com/fullstorydev/grpcurl/cmd/grpcurl@latest
```

### 全部接口
```
grpcurl -plaintext localhost:7779 list blog.BlogService
```

### 创建 blog
```
grpcurl -plaintext -d {"author_id": 1, "title": "post1"} localhost:7779 blog.BlogService.CreatePost

```

### 查看 blog
```
grpcurl -plaintext localhost:7779 blog.BlogService.ListPosts

```