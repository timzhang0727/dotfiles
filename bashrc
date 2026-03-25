# =============================================================================
# 通用 Bash 配置 - timzhang0727/dotfiles
# =============================================================================

# ---------- 颜色输出函数 ----------
red_echo ()      { echo -e "\033[031;1m$@\033[0m"; }
green_echo ()    { echo -e "\033[032;1m$@\033[0m"; }
yellow_echo ()   { echo -e "\033[033;1m$@\033[0m"; }
blue_echo ()     { echo -e "\033[034;1m$@\033[0m"; }

# ---------- 美化提示符 ----------
# 格式: [用户@主机 时间 目录]$
# 颜色: 用户(绿) @ 主机(蓝) 时间(黄) 目录(青)
export PS1="\[\e[37;40m\][\[\e[32;40m\]\u\[\e[37;40m\]@\[\e[34;40m\]\h \[\e[33;40m\]\t \[\e[36;40m\]\w\[\e[0m\]]\\$ "

# ---------- 常用别名 ----------
alias ll='ls -alh --color=auto'
alias la='ls -A --color=auto'
alias l='ls -CF --color=auto'
alias grep='grep --color=auto'
alias ..='cd ..'
alias ...='cd ../..'
alias cls='clear'

# ---------- 历史记录优化 ----------
export HISTSIZE=10000
export HISTFILESIZE=20000
export HISTCONTROL=ignoredups:erasedups
shopt -s histappend

# ---------- 快速登录配置 (跳板机专用) ----------
if [ -f ~/hosts ]; then
    alias g='_go'
    alias h='_host'

    function _go () {
        if echo $1 | grep -P '^((2(5[0-5]|[0-4]\d))|[0-1]?\d{1,2})(\.((2(5[0-5]|[0-4]\d))|[0-1]?\d{1,2})){3}$' >/dev/null ; then
            bf ssh_out root@"$1" -p 22
        else
            if (( $# == 0 )) ; then
                _host
                read -p "请输入要登陆的服务器ID: " target_id
                yellow_echo "--->"
                if [[ ! ${target_id} ]] ; then
                    red_echo "id is null , error"
                elif grep -w "^${target_id}" ~/hosts >/dev/null ; then
                    bf ssh_out root@"$(grep -w "^${target_id}" ~/hosts | awk '{print $3}')" -p 22
                else
                    red_echo "id not exists , error"
                fi
            elif grep -w "^$1" ~/hosts >/dev/null ; then
                bf ssh_out root@"$(grep -w "^$1" ~/hosts | awk '{print $3}')" -p 22
            else
                red_echo "id not exists , plz check"
            fi
        fi
    }

    function _host () {
        green_echo "=== 可用服务器列表 ==="
        awk '{printf "%-5s %-20s %-20s\n",$1,$2,$3}' ~/hosts | grep -v "^#"
        green_echo "====================="
    }
fi

# ---------- 实用函数 ----------
# 快速创建并进入目录
mkcd() { mkdir -p "$1" && cd "$1"; }

# 解压万能命令
extract() {
    if [ -f "$1" ]; then
        case "$1" in
            *.tar.bz2) tar xjf "$1" ;;
            *.tar.gz)  tar xzf "$1" ;;
            *.tar.xz)  tar xJf "$1" ;;
            *.bz2)     bunzip2 "$1" ;;
            *.gz)      gunzip "$1" ;;
            *.tar)     tar xf "$1" ;;
            *.zip)     unzip "$1" ;;
            *.7z)      7z x "$1" ;;
            *)         red_echo "不支持的格式: $1" ;;
        esac
    else
        red_echo "文件不存在: $1"
    fi
}

green_echo "✓ Dotfiles loaded!"
