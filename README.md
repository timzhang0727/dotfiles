# Dotfiles

我的个人 Shell 配置文件，支持一键部署到任意机器。

## 快速安装

### 方式一：一键安装（推荐）

```bash
curl -fsSL https://raw.githubusercontent.com/timzhang0727/dotfiles/main/install.sh | bash
```

### 方式二：手动安装

```bash
git clone https://github.com/timzhang0727/dotfiles.git ~/.dotfiles
echo '[ -f ~/.dotfiles/bashrc ] && source ~/.dotfiles/bashrc' >> ~/.bashrc
source ~/.bashrc
```

## 包含功能

### 美化提示符
- 彩色显示：用户名(绿)、主机名(蓝)、时间(黄)、目录(青)

### 常用别名
- `ll` - 详细列表
- `la` - 显示隐藏文件
- `..` / `...` - 快速返回上级目录
- `cls` - 清屏

### 实用函数
- `mkcd <dir>` - 创建目录并进入
- `extract <file>` - 万能解压命令

### 跳板机快速登录（需要 hosts 文件）
- `h` - 列出所有服务器
- `g 1` - 按 ID 登录
- `g 10.x.x.x` - 按 IP 登录

## hosts 文件格式

```
# ID  名称        IP地址
1     服务器1     10.x.x.x
2     服务器2     10.x.x.x
```

## 文件说明

| 文件 | 用途 |
|------|------|
| `bashrc` | Bash 配置 |
| `hosts.example` | 服务器列表示例 |
| `install.sh` | 一键安装脚本 |
