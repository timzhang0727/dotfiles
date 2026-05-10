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
| `obsidian/snippets/claude.css` | Obsidian CSS 主题片段 |

---

## Obsidian 主题：Claude

> 温暖、克制、有呼吸感的阅读与写作环境。

位于 [`obsidian/snippets/claude.css`](obsidian/snippets/claude.css)，作为 Obsidian CSS Snippet 使用，不依赖任何社区主题，叠加在官方主题之上即可。

### 安装方法

将 `claude.css` 复制到你的 Obsidian vault 的 `.obsidian/snippets/` 目录，然后在 **设置 → 外观 → CSS 代码片段** 中启用。

### 设计理念

- **字体**：正文用 Georgia / Noto Serif SC 衬线字体，标题用 Inter / PingFang SC 无衬线字体，代码用 JetBrains Mono，三套字体各司其职
- **色彩**：以暖米色为底，橙棕色（`#C67B2E`）作为 accent，深浅模式均有独立调色板
- **排版**：行高 1.85，行宽 700px，留白充分，长文阅读不疲劳

### 主要特性

| 特性 | 说明 |
|------|------|
| 编辑 / 阅读模式字体一致 | 统一声明 `--font-text`，覆盖 CM6 的 `.cm-content` 和 `.cm-line`，避免切换时字体跳变 |
| 代码块自动换行 | `pre-wrap` + `word-break: break-word`，长行不溢出也不强制横向滚动 |
| 代码块左侧 accent 条 | 3px 橙色左边框，层次感优于四周等粗边框 |
| 语言标签 | 阅读模式右上角浮出语言名，低调但有用 |
| 行内代码关闭连字 | `font-variant-ligatures: none`，防止 `->` `!=` 被合并变形 |
| 有序列表编辑模式修复 | 移除 Obsidian 默认的列表项 `border-bottom` 横线，收紧行间距 |
| 编号颜色与阅读模式对齐 | `.cm-formatting-list-ol` 着橙色 + interface 字体，切换模式无视觉跳变 |
