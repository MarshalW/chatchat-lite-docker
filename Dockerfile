# 使用ubuntu作为基础镜像
FROM ubuntu:22.04

# 设置时区环境变量
ENV TZ=Asia/Shanghai

# 设置时区
# 安装 python3/pip
RUN sed -i s@/archive.ubuntu.com/@/mirrors.tuna.tsinghua.edu.cn/@g /etc/apt/sources.list \
    && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone \
    && apt update && apt install python3 pip git -y \
    && pip config --user set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple 

# 安装额外的工具
RUN apt-get install -y \
    curl \
    nano

# 可能需要代理
# RUN git config --global http.proxy 'socks5h://172.17.0.1:1080' \
#     && git config --global https.proxy 'socks5h://172.17.0.1:1080'
RUN git clone https://github.com/chatchat-space/Langchain-Chatchat.git

WORKDIR /Langchain-Chatchat

RUN git checkout pre-release

RUN pip install -r requirements_lite.txt

RUN cd configs \
    && cp basic_config.py.example basic_config.py \
    && cp model_config.py.example model_config.py \
    && cp kb_config.py.example kb_config.py \
    && cp server_config.py.example server_config.py \
    && cp prompt_config.py.example prompt_config.py

RUN pip install sentence-transformers

WORKDIR /Langchain-Chatchat

COPY start.sh /Langchain-Chatchat

COPY requirements_lite.ext.txt /Langchain-Chatchat
RUN pip install -r requirements_lite.ext.txt

EXPOSE 8501

CMD ["bash","/Langchain-Chatchat/start.sh"]

