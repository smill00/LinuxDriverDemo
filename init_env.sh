#!/bin/bash

# 定义变量值（便于后续修改）
KERNEL_DIR_VALUE="/home/work/SDK/kernel"
TOOLCHAIN_DIR_VALUE="/home/work/SDK/gcc-linaro-6.3.1-2017.05-x86_64_aarch64-linux-gnu"
INSTALL_HOST_VALUE="root@192.168.2.33"

# 定义要添加的环境变量
ENV_VARS=("export KERNEL_DIR=$KERNEL_DIR_VALUE"
          "export TOOLCHINA_DIR=$TOOLCHAIN_DIR_VALUE"
          "export PATH=$SDKTOOLCHAIN_DIR_VALUE/bin:$PATH"
          "export INSTALL_HOST=$INSTALL_HOST_VALUE")

# 获取用户的bashrc文件路径
BASHRC_FILE="$HOME/.bashrc"

# 检查bashrc文件是否存在
if [ ! -f "$BASHRC_FILE" ]; then
    echo "错误: $BASHRC_FILE 文件不存在"
    exit 1
 fi

# 向bashrc文件添加环境变量
echo "正在向 $BASHRC_FILE 添加环境变量..."
for var in "${ENV_VARS[@]}"; do
    # 检查变量是否已经存在
    if ! grep -q "^$var" "$BASHRC_FILE"; then
        echo "$var" >> "$BASHRC_FILE"
        echo "添加: $var"
    else
        echo "跳过: $var (已存在)"
    fi
done

# 执行source命令使环境变量生效
echo "正在执行 source $BASHRC_FILE 使环境变量生效..."
source "$BASHRC_FILE"

echo "环境初始化完成！"
echo "当前环境变量设置："
echo "KERNEL_DIR: $KERNEL_DIR"
echo "TOOLCHINA_DIR: $TOOLCHINA_DIR"
echo "INSTALL_HOST: $INSTALL_HOST"
