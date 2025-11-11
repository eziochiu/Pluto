# 1. 基准镜像
FROM ubuntu:24.04

# 3. 环境变量
ENV DEBIAN_FRONTEND=noninteractive
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

# 5. 安装编译依赖
RUN \
    dpkg --add-architecture i386 && \
    apt-get update -y && \
    apt-get install -y --no-install-recommends \
    # --- AOSP 基础依赖 ---
    git-core \
    gnupg \
    flex \
    bison \
    build-essential \
    zip \
    curl \
    zlib1g-dev \
    libc6-dev \
    libncurses5-dev \
    libssl-dev \
    libxml2-utils \
    xsltproc \
    unzip \
    fontconfig \
    \
    # --- 常用工具 ---
    python3 \
    wget \
    rsync \
    openssh-client \
    ninja-build\
    cmake\
    gcc\
    g++\
    \
    # --- Google 'repo' 工具 ---
    repo \
    \
    # --- Java 开发环境 (默认 11) ---
    openjdk-11-jdk \
    && \
    # --- 清理缓存 ---
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# 6. 【重要修改】配置 Python 默认版本
# 因为 'python-is-python3' 在 18.04 不存在，我们手动配置
# 我们安装了 python3 (即 /usr/bin/python3) 和 python2.7
# 'update-alternatives' 用来管理 /usr/bin/python 链接
# 优先级 '2' 高于 '1'，所以 python3 会成为默认的 'python'
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 2

# 7. [可选] Java 版本 (如果需要 Java 8)
# RUN apt-get update -y && \
#     apt-get remove -y openjdk-11-jdk && \
#     apt-get install -y openjdk-8-jdk && \
#     apt-get clean && \
#     rm -rf /var/lib/apt/lists/*

# 8. 创建非 root 编译用户
RUN useradd -m -s /bin/bash builder
USER builder

# 9. 设置工作目录
WORKDIR /home/builder

# 10. 默认启动命令
CMD ["/bin/bash"]