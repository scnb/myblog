# 构建阶段
FROM nginx:alpine AS builder

# 运行阶段 - 直接把 public 复制到 Nginx
FROM nginx:alpine
COPY public/ /usr/share/nginx/html/
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
