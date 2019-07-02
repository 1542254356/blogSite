---
title: 安装hexo
date: 2018-12-27 17:41:38
tags: 博客配置
categories: 博客配置
---

前几天重装了Ubuntu16.04，重新装一下hexo。发现hexo网站的css好像没了。。。而且打开特别慢。不知道是不是被墙了，在这里做一下安装备份。省得以后打不开他们的网站。

## 安装git

```
sudo apt-get install git-core
```

## 安装 Node.js

```
curl https://raw.github.com/creationix/nvm/v0.33.11/install.sh | sh
```

或


```
wget -qO- https://raw.github.com/creationix/nvm/v0.33.11/install.sh | sh
```

安装完成后，重启终端并执行下列命令即可安装 Node.js。

```
nvm install stable
```

## 安装hexo

```
npm install -g hexo-cli
```

## 建站

建一个新文件夹，进入此文件夹。

```
hexo init
npm install
```

要是以前有建过，直接运行`npm install`好像也可以。

## 配置

在 _config.yml 中修改，根据说明填写。因为hexo官网打开后完全没有格式。我copy到了下面。

| `title`       | 网站标题                                                     |
| ------------- | ------------------------------------------------------------ |
| `subtitle`    | 网站副标题                                                   |
| `description` | 网站描述                                                     |
| `author`      | 您的名字                                                     |
| `language`    | 网站使用的语言                                               |
| `timezone`    | 网站时区。Hexo 默认使用您电脑的时区。[时区列表](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones)。比如说：`America/New_York`, `Japan`, 和 `UTC` 。 |

其中，`description`主要用于SEO，告诉搜索引擎一个关于您站点的简单描述，通常建议在其中包含您网站的关键词。`author`参数用于主题显示文章的作者。

注：此次语言中文填`zh-Hans` 。我也是百度了才知道的。。

## 网址

| 参数                 | 描述                                                         | 默认值                      |
| -------------------- | ------------------------------------------------------------ | --------------------------- |
| `url`                | 网址                                                         |                             |
| `root`               | 网站根目录                                                   |                             |
| `permalink`          | 文章的 [永久链接](https://hexo.io/zh-cn/docs/permalinks) 格式 | `:year/:month/:day/:title/` |
| `permalink_defaults` | 永久链接中各部分的默认值                                     |                             |

> 网站存放在子目录
>
> 如果您的网站存放在子目录中，例如 `http://yoursite.com/blog`，则请将您的 `url` 设为 `http://yoursite.com/blog` 并把 `root` 设为 `/blog/`。

## 目录

| 参数           | 描述                                                         | 默认值           |
| -------------- | ------------------------------------------------------------ | ---------------- |
| `source_dir`   | 资源文件夹，这个文件夹用来存放内容。                         | `source`         |
| `public_dir`   | 公共文件夹，这个文件夹用于存放生成的站点文件。               | `public`         |
| `tag_dir`      | 标签文件夹                                                   | `tags`           |
| `archive_dir`  | 归档文件夹                                                   | `archives`       |
| `category_dir` | 分类文件夹                                                   | `categories`     |
| `code_dir`     | Include code 文件夹                                          | `downloads/code` |
| `i18n_dir`     | 国际化（i18n）文件夹                                         | `:lang`          |
| `skip_render`  | 跳过指定文件的渲染，您可使用 [glob 表达式](https://github.com/isaacs/node-glob)来匹配路径。 |                  |

> 提示
>
> 如果您刚刚开始接触Hexo，通常没有必要修改这一部分的值。

## 文章

| 参数                | 描述                                                         | 默认值    |
| ------------------- | ------------------------------------------------------------ | --------- |
| `new_post_name`     | 新文章的文件名称                                             | :title.md |
| `default_layout`    | 预设布局                                                     | post      |
| `auto_spacing`      | 在中文和英文之间加入空格                                     | false     |
| `titlecase`         | 把标题转换为 title case                                      | false     |
| `external_link`     | 在新标签中打开链接                                           | true      |
| `filename_case`     | 把文件名称转换为 (1) 小写或 (2) 大写                         | 0         |
| `render_drafts`     | 显示草稿                                                     | false     |
| `post_asset_folder` | 启动 [Asset 文件夹](https://hexo.io/zh-cn/docs/asset-folders) | false     |
| `relative_link`     | 把链接改为与根目录的相对位址                                 | false     |
| `future`            | 显示未来的文章                                               | true      |
| `highlight`         | 代码块的设置                                                 |           |

> 相对地址
>
> 默认情况下，Hexo生成的超链接都是绝对地址。例如，如果您的网站域名为`example.com`,您有一篇文章名为`hello`，那么绝对链接可能像这样：`http://example.com/hello.html`，它是**绝对**于域名的。相对链接像这样：`/hello.html`，也就是说，无论用什么域名访问该站点，都没有关系，这在进行反向代理时可能用到。通常情况下，建议使用绝对地址。

## 分类 & 标签

| 参数               | 描述     | 默认值          |
| ------------------ | -------- | --------------- |
| `default_category` | 默认分类 | `uncategorized` |
| `category_map`     | 分类别名 |                 |
| `tag_map`          | 标签别名 |                 |

## 日期 / 时间格式

Hexo 使用 [Moment.js](http://momentjs.com/) 来解析和显示时间。

| 参数          | 描述     | 默认值       |
| ------------- | -------- | ------------ |
| `date_format` | 日期格式 | `YYYY-MM-DD` |
| `time_format` | 时间格式 | `H:mm:ss`    |

## 分页

| 参数             | 描述                                | 默认值 |
| ---------------- | ----------------------------------- | ------ |
| `per_page`       | 每页显示的文章量 (0 = 关闭分页功能) | `10`   |
| `pagination_dir` | 分页目录                            | `page` |

## 扩展

| 参数     | 描述                                |
| -------- | ----------------------------------- |
| `theme`  | 当前主题名称。值为`false`时禁用主题 |
| `deploy` | 部署部分的设置                      |

我的主题用的是next，deploy部分后面会说，先不用填。

## 基本命令

### init

```
$ hexo init [folder]
```

新建一个网站。如果没有设置 `folder` ，Hexo 默认在目前的文件夹建立网站。

### new

```
$ hexo new [layout] <title>
```

新建一篇文章。如果没有设置 `layout` 的话，默认使用 [_config.yml](https://hexo.io/zh-cn/docs/configuration) 中的 `default_layout` 参数代替。如果标题包含空格的话，请使用引号括起来。

### generate

```
$ hexo generate
```

生成静态文件。

| 选项             | 描述                   |
| ---------------- | ---------------------- |
| `-d`, `--deploy` | 文件生成后立即部署网站 |
| `-w`, `--watch`  | 监视文件变动           |

该命令可以简写为

```
$ hexo g
```



### publish

```
$ hexo publish [layout] <filename>
```

发表草稿。

### server

```
$ hexo server
```

启动服务器。默认情况下，访问网址为： `http://localhost:4000/`。

| 选项             | 描述                           |
| ---------------- | ------------------------------ |
| `-p`, `--port`   | 重设端口                       |
| `-s`, `--static` | 只使用静态文件                 |
| `-l`, `--log`    | 启动日记记录，使用覆盖记录格式 |

### deploy

```
$ hexo deploy
```

部署网站。

| 参数               | 描述                     |
| ------------------ | ------------------------ |
| `-g`, `--generate` | 部署之前预先生成静态文件 |

该命令可以简写为：

```
$ hexo d
```



### render

```
$ hexo render <file1> [file2] ...
```

渲染文件。

| 参数             | 描述         |
| ---------------- | ------------ |
| `-o`, `--output` | 设置输出路径 |

### migrate

```
$ hexo migrate <type>
```

从其他博客系统 [迁移内容](https://hexo.io/zh-cn/docs/migration)。

### clean

```
$ hexo clean
```

清除缓存文件 (`db.json`) 和已生成的静态文件 (`public`)。

在某些情况（尤其是更换主题后），如果发现您对站点的更改无论如何也不生效，您可能需要运行该命令。

###  list

```
$ hexo list <type>
```

列出网站资料。

### version

```
$ hexo version
```

显示 Hexo 版本。

## 选项

### 安全模式

```
$ hexo --safe
```

在安全模式下，不会载入插件和脚本。当您在安装新插件遭遇问题时，可以尝试以安全模式重新执行。

### 调试模式

```
$ hexo --debug
```

在终端中显示调试信息并记录到 `debug.log`。当您碰到问题时，可以尝试用调试模式重新执行一次，并 [提交调试信息到 GitHub](https://github.com/hexojs/hexo/issues/new)。

### 简洁模式

```
$ hexo --silent
```

隐藏终端信息。

### 自定义配置文件的路径

```
$ hexo --config custom.yml
```

自定义配置文件的路径，执行后将不再使用 `_config.yml`。

### 显示草稿

```
$ hexo --draft
```

显示 `source/_drafts` 文件夹中的草稿文章。

### 自定义 CWD

```
$ hexo --cwd /path/to/cwd
```

自定义当前工作目录（Current working directory）的路径。

### 文件名称

Hexo 默认以标题做为文件名称，但您可编辑 new_post_name 参数来改变默认的文件名称，举例来说，设为 :year-:month-:day-:title.md 可让您更方便的通过日期来管理文章。

| 变量       | 描述                                |
| ---------- | ----------------------------------- |
| `:title`   | 标题（小写，空格将会被替换为短杠）  |
| `:year`    | 建立的年份，比如， `2015`           |
| `:month`   | 建立的月份（有前导零），比如， `04` |
| `:i_month` | 建立的月份（无前导零），比如， `4`  |
| `:day`     | 建立的日期（有前导零），比如， `07` |
| `:i_day`   | 建立的日期（无前导零），比如， `7`  |

# Front-matter



Front-matter 是文件最上方以 `---` 分隔的区域，用于指定个别文件的变量，举例来说：

```
title: Hello World
date: 2013/7/13 20:46:25
---
```

以下是预先定义的参数，您可在模板中使用这些参数值并加以利用。

| 参数         | 描述                 | 默认值       |
| ------------ | -------------------- | ------------ |
| `layout`     | 布局                 |              |
| `title`      | 标题                 |              |
| `date`       | 建立日期             | 文件建立日期 |
| `updated`    | 更新日期             | 文件更新日期 |
| `comments`   | 开启文章的评论功能   | true         |
| `tags`       | 标签（不适用于分页） |              |
| `categories` | 分类（不适用于分页） |              |
| `permalink`  | 覆盖文章网址         |              |

## 分类和标签

只有文章支持分类和标签，您可以在 Front-matter 中设置。在其他系统中，分类和标签听起来很接近，但是在 Hexo 中两者有着明显的差别：分类具有顺序性和层次性，也就是说 `Foo, Bar` 不等于 `Bar, Foo`；而标签没有顺序和层次。

```
categories:
- Diary
tags:
- PS3
- Games
```

> 分类方法的分歧
>
> 如果您有过使用WordPress的经验，就很容易误解Hexo的分类方式。WordPress支持对一篇文章设置多个分类，而且这些分类可以是同级的，也可以是父子分类。但是Hexo不支持指定多个同级分类。下面的指定方法：
> categories:
> \- Diary
> \- Life
> 会使分类`Life`成为`Diary`的子分类，而不是并列分类。因此，有必要为您的文章选择尽可能准确的分类。

## 服务器

Hexo 3.0 把服务器独立成了个别模块，您必须先安装 [hexo-server](https://github.com/hexojs/hexo-server) 才能使用。

```
$ npm install hexo-server --save
```

安装完成后，输入以下命令以启动服务器，您的网站会在 `http://localhost:4000` 下启动。在服务器启动期间，Hexo 会监视文件变动并自动更新，您无须重启服务器。

```
$ hexo server
```

如果您想要更改端口，或是在执行时遇到了 `EADDRINUSE` 错误，可以在执行时使用 `-p` 选项指定其他端口，如下：

```
$ hexo server -p 5000
```



## 部署

此处使用ftp部署。

```
npm install hexo-deployer-ftpsync --save
```

修改配置。

deploy:
  type: ftpsync
  host: <host>
  user: <user>
  pass: <password>
  remote: [remote]
  port: [port]
  ignore: [ignore]
  connections: [connections]
  verbose: [true|false]

| 参数          | 描述             | 默认值 |
| ------------- | ---------------- | ------ |
| `host`        | 远程主机的地址   |        |
| `user`        | 使用者名称       |        |
| `pass`        | 密码             |        |
| `remote`      | 远程主机的根目录 | `/`    |
| `port`        | 端口             | 21     |
| `ignore`      | 忽略的文件或目录 |        |
| `connections` | 使用的连接数     | 1      |
| `verbose`     | 显示调试信息     | false  |

    FTP部署可能出现的问题
    
    您可能需要预先通过其他方式将所有文件上传到远程主机中。否则初次使用ftpsync插件就可能出现报错。另外，由于FTP协议的特征，它每传送一个文件就需要一次握手，相对速度较慢。


## 永久链接

可以修改`config.yml`里面的`permalink`属性修改链接格式。

```
permalink: :category/:title
```

## next主题

next的文档暂时没出现hexo文档这样的无法访问的情况，就直接看[next文档](http://theme-next.iissnan.com/getting-started.html) 吧。



