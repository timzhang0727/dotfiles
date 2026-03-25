#!/bin/bash
# =============================================================================
# Dotfiles 一键安装脚本
# 用法: curl -fsSL https://raw.githubusercontent.com/timzhang0727/dotfiles/main/install.sh | bash
# =============================================================================

set -e

REPO_URL="https://github.com/timzhang0727/dotfiles.git"
RAW_URL="https://raw.githubusercontent.com/timzhang0727/dotfiles/main"
DOTFILES_DIR="$HOME/.dotfiles"

green_echo() { echo -e "\033[032;1m$@\033[0m"; }
yellow_echo() { echo -e "\033[033;1m$@\033[0m"; }
red_echo() { echo -e "\033[031;1m$@\033[0m"; }

green_echo "=== Dotfiles 安装脚本 ==="

# 检测当前 shell
CURRENT_SHELL=$(basename "$SHELL")
green_echo "检测到 Shell: $CURRENT_SHELL"

# 创建目录
mkdir -p "$DOTFILES_DIR"

# 检测是否有 git
if command -v git &> /dev/null; then
    # 有 git，用 git clone
    if [ -d "$DOTFILES_DIR/.git" ]; then
        yellow_echo "更新已有的 dotfiles (git pull)..."
        cd "$DOTFILES_DIR" && git pull
    else
        yellow_echo "克隆 dotfiles 仓库..."
        rm -rf "$DOTFILES_DIR"
        git clone "$REPO_URL" "$DOTFILES_DIR"
    fi
else
    # 没有 git，用 curl 直接下载
    yellow_echo "未检测到 git，使用 curl 下载..."
    curl -fsSL "$RAW_URL/bashrc" -o "$DOTFILES_DIR/bashrc"
    curl -fsSL "$RAW_URL/hosts.example" -o "$DOTFILES_DIR/hosts.example"
    green_echo "✓ 文件下载完成"
fi

# 备份现有 .bashrc
if [ -f "$HOME/.bashrc" ]; then
    yellow_echo "备份现有 .bashrc -> .bashrc.backup"
    cp "$HOME/.bashrc" "$HOME/.bashrc.backup"
fi

# 追加配置到 .bashrc（而不是覆盖）
if ! grep -q "dotfiles loaded" "$HOME/.bashrc" 2>/dev/null; then
    yellow_echo "添加配置到 .bashrc..."
    echo "" >> "$HOME/.bashrc"
    echo "# Load dotfiles configuration" >> "$HOME/.bashrc"
    echo "[ -f ~/.dotfiles/bashrc ] && source ~/.dotfiles/bashrc" >> "$HOME/.bashrc"
fi

# 复制 hosts 示例（如果不存在）
if [ ! -f "$HOME/hosts" ] && [ -f "$DOTFILES_DIR/hosts.example" ]; then
    yellow_echo "创建 hosts 文件..."
    cp "$DOTFILES_DIR/hosts.example" "$HOME/hosts"
fi

green_echo ""
green_echo "✓ 安装完成！"
green_echo ""

# 自动生效并清屏
source "$HOME/.bashrc" && clear

green_echo "=== Dotfiles 已生效 ==="
green_echo "常用命令："
green_echo "  h     - 查看服务器列表"
green_echo "  g 1   - 按 ID 登录服务器"
green_echo "  ll    - 详细列表"
green_echo "  mkcd  - 创建并进入目录"
