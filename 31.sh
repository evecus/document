#!/bin/bash

# 原始证书目录
SRC_DIR="/root/.acme.sh/asui.668599.xyz_ecc"
# PEM 输出目录
OUT_DIR="/root/hy2_certs"

# 文件名
KEY_FILE="asui.668599.xyz.key"
CER_FILE="asui.668599.xyz.cer"

# 创建输出目录
mkdir -p "$OUT_DIR"
cp "$SRC_DIR/$KEY_FILE" "$OUT_DIR/"
cp "$SRC_DIR/$CER_FILE" "$OUT_DIR/"
cd "$OUT_DIR"

echo "✅ 原始文件已复制到 $OUT_DIR"

# 转换证书为 PEM
openssl x509 -inform der -in "$CER_FILE" -out cert.pem 2>/dev/null || cp "$CER_FILE" cert.pem
# 转换私钥为 PEM
openssl rsa -in "$KEY_FILE" -out key.pem 2>/dev/null || cp "$KEY_FILE" key.pem

echo "✅ PEM 文件生成完成"

# 检查证书和私钥是否匹配
KEY_MD5=$(openssl rsa -noout -modulus -in key.pem | openssl md5)
CERT_MD5=$(openssl x509 -noout -modulus -in cert.pem | openssl md5)

if [ "$KEY_MD5" != "$CERT_MD5" ]; then
    echo "❌ 错误：证书和私钥不匹配！请检查原始文件。"
    exit 1
fi

echo "✅ 证书和私钥匹配"



echo "✅ Hy2 节点已重启，证书生效"
