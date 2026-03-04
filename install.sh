#!/bin/bash

# 检查参数是否提供
if [ $# -ne 1 ]; then
    echo "用法: $0 <目录路径>"
    echo "例如: $0 01_hello_driver"
    exit 1
 fi

# 获取目录参数
DIR="$1"

# 检查目录是否存在
if [ ! -d "$DIR" ]; then
    echo "错误: 目录 $DIR 不存在"
    exit 1
 fi

# 检查环境变量是否设置
if [ -z "$INSTALL_HOST" ]; then
    echo "错误: 环境变量 INSTALL_HOST 未设置"
    echo "请设置 INSTALL_HOST 为 '用户名@主机:端口' 格式"
    exit 1
 fi

# 查找目录下的所有 .ko 文件
KO_FILES=$(find "$DIR" -name "*.ko" 2>/dev/null)

# 检查是否找到 .ko 文件
if [ -z "$KO_FILES" ]; then
    echo "错误: 在目录 $DIR 中未找到 .ko 文件"
    exit 1
 fi

# 定义远程目标目录（可根据需要修改）
REMOTE_DIR="/lib/modules/$(uname -r)/kernel/drivers/"

# 打印信息
echo "正在安装 .ko 文件到远程主机 $INSTALL_HOST..."
echo "目标目录: $REMOTE_DIR"
echo "找到的 .ko 文件:"
echo "$KO_FILES"

# 复制 .ko 文件到远程主机
for ko_file in $KO_FILES; do
    echo "正在复制: $ko_file"
    scp -P "${INSTALL_HOST##*:}" "$ko_file" "${INSTALL_HOST%:*}":"$REMOTE_DIR"
    if [ $? -ne 0 ]; then
        echo "错误: 复制 $ko_file 失败"
        exit 1
    fi
done

echo "安装完成！"
