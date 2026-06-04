# My Blog 🚀

基于 **Hugo + PaperMod** 的个人博客系统。

## 📝 本地写作

```bash
# 新建文章
hugo new posts/my-new-article/index.md

# 本地预览（局域网可访问）
./serve.sh
# 或
hugo server -D
```

访问 http://localhost:1313 预览。

## 🚀 部署方案

### 方案一：GitHub Pages（免费，推荐）

1. 在 GitHub 创建仓库，推送到 `main` 分支
2. 修改 `config.toml` 的 `baseURL` 为 `https://你的用户名.github.io/`
3. 进入仓库 Settings → Pages → 选择 **GitHub Actions** 作为 Source
4. 推送代码，GitHub Actions 自动构建部署

### 方案二：云服务器（Nginx）

```bash
# 1. 本地构建
hugo --minify

# 2. 上传到服务器
scp -r public/ root@你的IP:/var/www/blog/

# 3. 服务器上装 Nginx
ssh root@你的IP
apt install nginx
# 把 nginx.conf 放到 /etc/nginx/sites-available/blog
# 配置好域名即可
```

### 方案三：Docker 部署

```bash
# 先构建静态文件
hugo --minify

# 构建并运行 Docker
docker-compose up -d
```

### 方案四：GitHub Actions 自动部署到 VPS

1. 在仓库 Secrets 添加:
   - `VPS_HOST` - 服务器 IP
   - `VPS_USER` - SSH 用户名
   - `VPS_SSH_KEY` - SSH 私钥
   - `VPS_DEPLOY_PATH` - 部署路径（如 `/var/www/blog`）
2. 推送到 `main` 分支自动部署

## 🛠 项目结构

```
├── config.toml              # 博客配置
├── content/                 # 文章目录（Markdown）
│   ├── about/               # 关于页面
│   ├── archives/            # 归档
│   ├── posts/               # 博客文章
│   └── search/              # 搜索页面
├── themes/PaperMod/         # PaperMod 主题
├── public/                  # 构建产物（部署用）
├── .github/workflows/       # GitHub Actions 自动部署
├── Dockerfile               # Docker 部署
├── nginx.conf               # Nginx 配置
└── serve.sh                 # 本地开发启动脚本
```
