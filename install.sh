#!/bin/bash
# =============================================================================
# Dotfiles 一键安装脚本
# 用法: curl -fsSL https://raw.githubusercontent.com/timzhang0727/dotfiles/main/install.sh | bash
# =============================================================================

set -e

REPO_URL="https://github.com/timzhang0727/dotfiles.git"
DOTFILES_DIR="$HOME/.dotfiles"

green_echo() { echo -e "\033[032;1m$@\033[0m"; }
yellow_echo() { echo -e "\033[033;1m$@\033[0m"; }
red_echo() { echo -e "\033[031;1m$@\033[0m"; }

green_echo "=== Dotfiles 安装脚本 ==="

# 检测当前 shell
CURRENT_SHELL=$(basename "$SHELL")
green_echo "检测到 Shell: $CURRENT_SHELL"

# 克隆或更新仓库
if [ -d "$DOTFILES_DIR" ]; then
    yellow_echo "更新已有的 dotfiles..."
    cd "$DOTFILES_DIR" && git pull
else
    yellow_echo "克隆 dotfiles 仓库..."
    git clone "$REPO_URL" "$DOTFILES_DIR"
fi

# 备份并链接 bashrc
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
green_echo "运行以下命令使配置生效："
green_echo "  source ~/.bashrc"
green_echo ""
green_echo "或者重新登录 shell"
