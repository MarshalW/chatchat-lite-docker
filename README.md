# chatchat lite 

[Langchain-Chatchat](https://github.com/chatchat-space/Langchain-Chatchat) 轻量级的 docker compose 部署项目。

要求：

- linux 系统
- 安装了 docker

执行命令：

```bash
# 下载项目
git clone xx
cd xx

# 创建环境变量文件
cp .env.example .env
# 修改 .env 中的 key
nano .env

# 运行
# 第一次会构建镜像 - 比较慢
docker compose up -d
```
