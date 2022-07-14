# 模板

## 目录结构

```console
.
├── skeleton  
└── templates
```

- `skeleton`，此目录下文件为模板框架代码，需要原样复制到项目目录

- `templates`，根据数据表, 目录下文件会为数据表生成相应的文件。替换变量后的文件，会生成到配置文件中 `templates` 段指定的位置。例如 ：
  
  数据表有 `table1 table2`， 配置项中 `templates` 的目标路径配置为 `service`

    `service.tmpl` - 这个模板文件会生成 `service/table1.go service/table2.go` 两个文件。

```console
templates
    └──service.tmpl
    
```

## 官方模板

- [x] [grpc](https://github.com/ychengcloud/contrib/tree/main/grpc) - 符合 Golang 设计哲学的工程框架,支持查询过滤、排序、分页、指定返回字段、批量创建、批量查询、批量更新、批量删除


## 社区模板

等待你的添加

## 模板变量

- 根变量

| 名称      | 说明         | 类型      | 默认值 | 例子 |
| --------- | ------------ | --------- | ------ | ---- |
| Schema    | 数据库       | Schema    | -      | -    |
| Project   | 项目名       | string    | -      | -    |
| Package   | 包名         | string    | -      | -    |
| Generator | 生成相关信息 | Generator | -      | -    |

- Schema
| 名称       | 说明                  | 类型    | 默认值 | 例子 |
| ---------- | --------------------- | ------- | ------ | ---- |
| Name       | 数据库名              | string  | -      | -    |
| Tables     | 非关联表的 Table 列表 | []Table | -      | -    |
| Table      | 指定表名的表信息      | Table   | -      | -    |
| JoinTables | 关联表的 Table 列表   | []Table | -      | -    |
| JoinTable  | 指定表名的关联表信息  | Table   | -      | -    |

- Table
| 名称           | 说明             | 类型    | 默认值 | 例子 |
| -------------- | ---------------- | ------- | ------ | ---- |
| Name           | 表名             | string  | -      | -    |
| JoinTable      | 是否关联表       | bool    | -      | -    |
| ID             | 主键字段         | Field   | -      | -    |
| Schema         | 数据库           | Schema  | -      | -    |
| Fields         | 数据表字段列表   | []Field | -      | -    |
| FilterFields   | 数据表可过滤字段 | []Field | -      | -    |
| HasFilterField | 是否有可过滤字段 | bool    | -      | -    |
| HasParent      | 是否有父资源     | bool    | -      | -    |
| HasRelations   | 是否有关联字段   | bool    | -      | -    |
| AutoIncrement  | 主键是否自增长   | bool    | -      | -    |

- Field
| 名称          | 说明                          | 类型   | 默认值 | 例子 |
| ------------- | ----------------------------- | ------ | ------ | ---- |
| Name          | 字段名                        | string | -      | -    |
| Type          | 字段类型                      | Type   | -      | -    |
| Nullable      | 是否可空                      | bool   | false  | true |
| Optional      | 是否可选                      | bool   | false  | true |
| Sensitive     | 是否敏感                      | bool   | false  | true |
| Tag           | tag                           | string | -      | -    |
| Comment       | 数据表描述信息                | string | -      | -    |
| Alias         | 别名                          | string | -      | -    |
| Sortable      | 是否可排序                    | bool   | false  | true |
| Filterable    | 是否可过滤                    | bool   | false  | true |
| ForeignKey    | 是否外键                      | bool   | -      |
| PrimaryKey    | 是否主键                      | bool   | -      |
| Index         | 是否索引                      | bool   | false  | true |
| Unique        | 是否唯一                      | bool   | false  | true |
| AutoIncrement | 是否自增长                    | bool   | false  | true |
| Remote        | 是否远端字段                  | bool   | false  | true |
| Ops           | 支持逻辑操作符列表            | []Op   | -      | -    |
| RelNone       | 是否原始字段                  | bool   | false  | -    |
| RelBelongsTo  | 是否 BelongsTo 型关联字段     | bool   | false  | -    |
| RelHasOne     | 是否 HasOne 型关联字段        | bool   | false  | -    |
| RelHasMany    | 是否 RelHasMany 型关联字段    | bool   | false  | -    |
| RelManyToMany | 是否 RelManyToMany 型关联字段 | bool   | false  | -    |

- Op
| 名称 | 说明     | 类型   | 默认值 | 例子 |
| ---- | -------- | ------ | ------ | ---- |
| Name | 操作符名 | string | -      | -    |

- Op Name
| 名称       | 说明       | 类型   | 默认值 | 例子 |
| ---------- | ---------- | ------ | ------ | ---- |
| Eq         | 等于       | string | -      | -    |
| Neq        | 等于       | string | -      | -    |
| In         | 集合中     | string | -      | -    |
| NotIn      | 非集合中   | string | -      | -    |
| Gt         | 大于       | string | -      | -    |
| Gte        | 大于或等于 | string | -      | -    |
| Lt         | 小于       | string | -      | -    |
| Lte        | 小于或等于 | string | -      | -    |
| IsNil      | 空         | string | -      | -    |
| NotNil     | 非空       | string | -      | -    |
| Contains   | 包含       | string | -      | -    |
| StartsWith | 开始       | string | -      | -    |
| EndsWith   | 结束       | string | -      | -    |
| AND        | 与         | string | -      | -    |
| OR         | 或         | string | -      | -    |
| NOT        | 非         | string | -      | -    |

- Generator
| 名称   | 说明       | 类型   | 默认值 | 例子 |
| ------ | ---------- | ------ | ------ | ---- |
| Cfg    | 项目配置   | Config | -      | -    |
| Loader | 数据库信息 | Loader | -      | -    |

- Config 
| 名称    | 说明           | 类型   | 默认值 | 例子 |
| ------- | -------------- | ------ | ------ | ---- |
| Project | 项目名         | string | -      | -    |
| Package | 包名           | string | -      | -    |
| Header  | 生产文件头信息 | string | -      | -    |
| Dialect | 数据库类型     | string | -      | -    |
| DSN     | 数据库连接信息 | string | -      | -    |
| Delim   | 模板变量标识符 | Delim  | -      | -    |
| Root    | 模板根目录     | string | -      | -    |
| GenRoot | 生成根目录     | string | -      | -    |
| Attrs   | 数据表信息     | map    | -      | -    |

- Loader
| 名称    | 说明       | 类型   | 默认值 | 例子  |
| ------- | ---------- | ------ | ------ | ----- |
| Dialect | 数据库类型 | string | -      | mysql |

- Delim 
| 名称  | 说明         | 类型   | 默认值 | 例子 |
| ----- | ------------ | ------ | ------ | ---- |
| Left  | 变量左分隔符 | string | {{     | -    |
| Right | 变量右分隔符 | string | }}     | -    |

## 模板方法

- 方法列表 
| 名称     | 说明              | 类型   | 默认值 | 例子    |
| -------- | ----------------- | ------ | ------ | ------- |
| receiver | 函数接收名        | string | -      | -       |
| snake    | snake形式转化     | string | -      | user_id |
| pascal   | pascal 形式转化   | string | -      | UserId  |
| camel    | camel  形式转化   | string | -      | userId  |
| plural   | plural 形式转化   | string | -      | users   |
| singular | singular 形式转化 | string | -      | user    |

注： 支持 [sprig](https://github.com/Masterminds/sprig) 的所有方法




