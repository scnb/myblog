#!/bin/bash
# ==========================================
# 手动部署脚本 — Hugo 博客一键发布到云服务器
# 使用方法:
#   ./deploy.sh                        # 默认部署
#   ./deploy.sh user@your-server.com   # 指定服务器
#   ./deploy.sh prod                   # 使用 deploy.conf 里的配置
# ==========================================

set -e

# 配置（可以直接修改，或创建 deploy.conf 覆盖）
if [ -f deploy.conf ]; then
    source deploy.conf
else
    SSH_TARGET="${1:-root@your-server.com}"
    REMOTE_PATH="/var/www/blog"
fi

echo "🚀 开始构建..."
hugo --minify

echo "📦 上传到服务器..."
rsync -avz --delete public/ "${SSH_TARGET}:${REMOTE_PATH}"

echo "✅ 部署完成！"
echo "   🌍 地址: http://${SSH_TARGET#*@}"
