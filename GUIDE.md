# 📘 MyBlog 使用指南

> Hugo + PaperMod 博客系统 — 完整操作手册

---

## 📋 目录

- [一、项目结构](#一项目结构)
- [二、写文章](#二写文章)
- [三、分类与标签](#三分文章分类与标签)
- [四、本地预览](#四本地预览)
- [五、发布上线](#五发布上线)
- [六、修改博客配置](#六修改博客配置)
- [七、自定义首页](#七自定义首页-可选)
- [八、添加评论系统](#八添加评论系统-可选)
- [九、绑定自定义域名](#九绑定自定义域名-可选)
- [十、常见问题](#十常见问题)

---

## 一、项目结构

```
/opt/MyBlog/
│
├── config.toml               ← ⚙️ 博客配置文件（改这里定制博客）
├── content/                  ← 📝 所有文章都在这里
│   ├── about/                ←   关于页面
│   ├── archives/             ←   文章归档
│   ├── posts/                ←   📂 博客文章目录
│   │   ├── hello-world/      ←     第一篇示例文章
│   │   └── .../              ←     你新建的文章
│   └── search/               ←   搜索页面
│
├── themes/PaperMod/          ← 🎨 主题文件（一般不用改）
├── public/                   ← 🌍 构建产物（部署用，不用手动管）
├── .github/workflows/        ← 🤖 GitHub Actions 自动部署配置
│
├── Dockerfile                ← Docker 部署文件
├── nginx.conf                ← Nginx 服务器配置
├── docker-compose.yml        ← Docker Compose 配置
├── deploy.sh                 ← 手动部署脚本
├── serve.sh                  ← 本地预览脚本
├── Makefile                  ← 常用命令快捷方式
└── README.md                 ← 项目说明
```

---

## 二、写文章

### 2.1 新建文章

```bash
cd /opt/MyBlog

# 方式一：hugo 命令
hugo new posts/文章名/index.md

# 方式二：make 快捷方式
make new-post POST_NAME=文章名
```

### 2.2 文章模板

新建后会生成一个 Markdown 文件，头部是 `front matter`（元数据）：

```markdown
---
date: '2026-06-06T10:00:00+08:00'
draft: true
title: '文章标题'
description: '文章摘要，会显示在首页列表'
tags: ['标签1', '标签2']
categories: ['分类名']
---

## 正文开始

用 Markdown 写文章内容...

### 代码示例

```python
print("Hello Blog!")
```

### 图片

![图片描述](图片链接)

### 链接

[链接文字](https://example.com)
```

### 2.3 关键字段说明

| 字段 | 说明 | 必填 |
|------|------|------|
| `title` | 文章标题 | ✅ |
| `date` | 发布日期，自动生成 | ✅ |
| `draft` | `true`=草稿 / `false`=已发布 | ✅ 记得改 |
| `description` | 文章摘要，显示在首页 | 推荐 |
| `tags` | 标签列表 | 可选 |
| `categories` | 分类 | 可选 |

### 2.4 Markdown 速查

```markdown
# 一级标题
## 二级标题
### 三级标题

**粗体**  *斜体*  ~~删除线~~

- 无序列表项
- 无序列表项

1. 有序列表项
2. 有序列表项

`行内代码`

```语言名
代码块
```

> 引用文字

[链接](url)

![图片](url)
```

---

## 三、文章分类与标签

### 分类 vs 标签

```
分类（categories）                 标签（tags）
   │                                  │
   ├── 技术                           ├── Go
   ├── 生活                           ├── Kubernetes
   ├── 旅行                           ├── 算法
   └── 随笔                           ├── 读书笔记
                                      └── Vlog
```

**使用规则：**

| | 分类 | 标签 |
|--|------|------|
| 用途 | 大的文章类别 | 具体的关键词 |
| 数量 | 一篇文章建议 1 个 | 一篇文章多个 |
| 层级 | 平级，不嵌套 | 平级，不嵌套 |
| 页面 | 自动生成分类页 | 自动生成标签页 |

**示例：**

```markdown
---
title: '用 Go 写一个 Web 服务器'
tags: ['Go', 'Web', '后端']
categories: ['技术']
---
```

---

## 四、本地预览

### 4.1 预览全部文章（含草稿）

```bash
# 方式一
./serve.sh

# 方式二
hugo server -D
```

启动后访问：
- **本机**: http://localhost:1313
- **局域网其他设备**: http://192.168.1.13:1313

> 按 `Ctrl+C` 停止服务器

### 4.2 只预览已发布的文章

```bash
hugo server
```

（不加 `-D` 就不会显示 `draft: true` 的文章）

---

## 五、发布上线

### 方式一：推送到 GitHub（自动部署）

```bash
# 三步走
cd /opt/MyBlog

git add .
git commit -m "📝 新文章：文章标题"
git push
```

推送后：
1. ✅ GitHub Actions 自动运行
2. ✅ 构建 Hugo 静态文件
3. ✅ 部署到 GitHub Pages

**等 1-2 分钟**，访问 https://scnb.github.io/myblog/

### 方式二：手动构建 + 上传（备用）

```bash
# 构建
hugo --minify

# 上传到云服务器
rsync -avz public/ root@你的服务器IP:/var/www/blog/

# 或使用部署脚本
./deploy.sh root@你的服务器IP
```

### 查看部署状态

https://github.com/scnb/myblog/actions

---

## 六、修改博客配置

编辑 `config.toml` 文件：

### 6.1 修改博客标题

```toml
title = "我的个人博客"
```

### 6.2 修改首页欢迎语

```toml
[params.homeInfoParams]
  Title = "Hi，欢迎来到我的博客 👋"
  Content = """
这里是我的个人空间，分享技术与生活。
- 💻 技术笔记
- 📚 读书心得
- 🌍 旅行见闻
"""
```

### 6.3 修改社交媒体链接

```toml
[[params.socialIcons]]
  name = "github"
  url = "https://github.com/你的用户名"

[[params.socialIcons]]
  name = "x"
  url = "https://x.com/你的用户名"

[[params.socialIcons]]
  name = "email"
  url = "mailto:你的邮箱@example.com"
```

可用的图标：`github` / `x` / `email` / `linkedin` / `weibo` / `zhihu` / `bilibili` / `youtube` 等。

### 6.4 修改导航菜单

```toml
[[menu.main]]
  name = "关于"
  url = "about"
  weight = 1

[[menu.main]]
  name = "分类"          # 新增一个分类导航
  url = "categories"
  weight = 5
```

`weight` 越小越靠左。

### 6.5 修改每页显示文章数

```toml
pagination.pagerSize = 10    # 默认5，改为10
```

### 6.6 常用开关

```toml
ShowReadingTime = true       # 显示阅读时间
ShowShareButtons = true      # 显示分享按钮
ShowBreadCrumbs = true       # 显示面包屑导航
ShowCodeCopyButtons = true   # 显示代码复制按钮
ShowToc = true               # 显示目录
ShowPostNavLinks = true      # 显示上一篇/下一篇
```

### 6.7 修改主题色

新建文件 `assets/css/extended/custom.css`：

```css
:root {
  --primary: rgb(30, 30, 30);        /* 主文字颜色 */
  --theme: rgb(255, 255, 255);       /* 背景色 */
  --secondary: rgb(108, 108, 108);   /* 次要文字颜色 */
}
.dark {
  --primary: rgb(218, 218, 219);
  --theme: rgb(29, 30, 32);
}
```

> **改了配置后记得推送到 GitHub 才会生效**

---

## 七、自定义首页（可选）

默认 PaperMod 是 "Home-Info Mode"，显示欢迎语 + 最新文章。

想改成和 nsddd.top 一样的全定制首页，需要手写 `layouts/index.html`。需要时找我就行 😊

---

## 八、添加评论系统（可选）

推荐 [Giscus](https://giscus.app/) — 基于 GitHub Discussions 的评论系统：

1. 去 https://github.com/settings/installations 安装 Giscus App
2. 去 https://giscus.app 配置，获得 `data-repo` 等参数
3. 新建文件 `layouts/partials/comments.html`：

```html
<script src="https://giscus.app/client.js"
  data-repo="你的用户名/仓库名"
  data-repo-id="..."
  data-category="Announcements"
  data-category-id="..."
  data-mapping="pathname"
  data-strict="0"
  data-reactions-enabled="1"
  data-emit-metadata="0"
  data-input-position="bottom"
  data-theme="preferred_color_scheme"
  data-lang="zh-CN"
  crossorigin="anonymous"
  async>
</script>
```

---

## 九、绑定自定义域名（可选）

1. 在 `config.toml` 修改：

```toml
baseURL = "https://你的域名.com/"
```

2. 在域名 DNS 管理加一条 **CNAME 记录**：
   - 名称：`www` 或 `@`
   - 目标：`scnb.github.io`

3. 推到 GitHub 等待部署完成

---

## 十、常见问题

### Q: 写完后忘记改 draft 了怎么办？
A: 重新编辑文件，把 `draft: true` 改成 `draft: false`，再推一次。

### Q: 本地预览和线上不一致？
A: 本地运行 `hugo --minify` 然后打开 `public/index.html` 看看，这是线上生成的文件。

### Q: 图片放哪里？
A: 两种方式：
- **外部图床**：直接引用 URL（推荐，省仓库空间）
- **本地**：放在 `static/images/` 目录，引用 `/images/图片名.png`

### Q: 想改文章顺序？
A: 文章的 `date` 字段决定排序，改日期即可。

### Q: 页面还是没样式？
A: 浏览器强制刷新 `Ctrl+F5`，或清除缓存后再试。

### Q: 想修改关于页面？
A: 编辑 `content/about/index.md`。

### Q: 怎么更新 PaperMod 主题？
A: 需要联网时执行：
```bash
cd themes/PaperMod && git pull
```

---

## 🚀 速查卡片

```bash
# 📝 写文章
hugo new posts/文章名/index.md

# 👀 本地预览
./serve.sh

# 📤 发布
git add .
git commit -m "📝 新文章"
git push

# ⚙️ 改配置
vim config.toml
```
