# Grpc Server

[项目地址](https://github.com/ychengcloud/grpc-template)

## Features

- 符合 Golang 设计哲学的工程框架
- 符合 [Google Aip](https://google.aip.dev/) 规范
- 支持 查询过滤、排序、分页、指定返回字段
- 支持 批量创建、批量查询、批量更新、批量删除
- 自动生成 OpenApi 文档
- 用最自然的方法解决 N + 1 问题
- 框架代码自主可控，初始生成后可根据业务需要灵活修改
- 集成标准监控和日志组件 OpenTracing, ZapLog, Promtheus

## 安装依赖

- [Make](setup-make.md)
- [Golang 1.16+](https://golang.org/doc/install)
- [Mysql 8.0+](https://dev.mysql.com/doc/refman/8.0/en/installing.html)
- [cre 0.1.10+](setup-local.md) 
- [gowatch](https://github.com/silenceper/gowatch) (可选)

## 项目生成

参见 [cre](https://docs.ycheng.pro/cre)


## 运行项目

项目生成后，根据业务情况修改配置文件，即可构建运行


### 修改项目配置文件

config.default.yaml 为全部可配置项, 默认新建 config.yaml，只需要添加需要覆盖的配置项即可。

### 编译

    make build

### 启动

    make run

## 运行配置项说明

参见配置文件注释
