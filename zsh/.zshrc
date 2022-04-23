# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

if [[ ! -f $HOME/.zi/bin/zi.zsh ]]; then
  print -P "%F{33}▓▒░ %F{160}Installing (%F{33}z-shell/zi%F{160})…%f"
  command mkdir -p "$HOME/.zi" && command chmod g-rwX "$HOME/.zi"
  command git clone -q --depth=1 --branch "main" https://github.com/z-shell/zi "$HOME/.zi/bin" && \
    print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
    print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi
source "$HOME/.zi/bin/zi.zsh"
autoload -Uz _zi
(( ${+_comps} )) && _comps[zi]=_zi
# examples here -> https://z.digitalclouds.dev/docs/ecosystem/annexes
zicompinit # <- https://z.digitalclouds.dev/docs/guides/commands
zi light-mode for \
  z-shell/z-a-meta-plugins \
  @annexes # <- https://z.digitalclouds.dev/docs/ecosystem/annexes
# examples here -> https://z.digitalclouds.dev/docs/gallery/collection
zicompinit # <- https://z.digitalclouds.dev/docs/guides/commands


# 快速目录跳转
zi ice lucid wait='1'
zi light skywind3000/z.lua

# 语法高亮 自动建议 补全
zi wait lucid for \
 atinit"ZI[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
    z-shell/F-Sy-H \
 blockf \
    zsh-users/zsh-completions \
 atload"!_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions

zi ice lucid wait='0'
zi load z-shell/H-S-MW

# 加载 OMZ 框架及部分插件
zi snippet OMZ::lib/completion.zsh
zi snippet OMZ::lib/history.zsh
zi snippet OMZ::lib/key-bindings.zsh
zi snippet OMZ::lib/theme-and-appearance.zsh
zi snippet OMZ::plugins/colored-man-pages/colored-man-pages.plugin.zsh
zi snippet OMZ::plugins/sudo/sudo.plugin.zsh

zi snippet OMZ::plugins/extract

zi ice lucid wait='1'
zi snippet OMZ::plugins/git/git.plugin.zsh

# ---- (可选)加载了一堆二进制程序 ----
zi light z-shell/z-a-bin-gem-node
zi as="null" wait="1" lucid from="gh-r" for \
    mv="exa* -> exa" sbin="bin/exa"       ogham/exa \
    mv="*/rg -> rg"  sbin		BurntSushi/ripgrep \
    mv="fd* -> fd"   sbin="fd/fd"  @sharkdp/fd \
    sbin="fzf"       junegunn/fzf-bin


# 不需要花里胡哨的 ls，我们有更花里胡哨的 exa
DISABLE_LS_COLORS=true
alias ls=exa
# 配置 fzf 使用 fd
export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --preview '(highlight -O ansi {} || cat {}) 2> /dev/null | head -500'"
# ---- 加载完了 ----

export RUSTUP_DIST_SERVER='https://mirrors.ustc.edu.cn/rust-static'
export RUSTUP_UPDATE_ROOT='https://mirrors.ustc.edu.cn/rust-static/rustup'
export PATH=$PATH:"$HOME/.local/bin"

alias proxy="source ~/.wsl_proxy.sh" 

function glog() {
    setterm -linewrap off
    git --no-pager log --all --color=always --graph --abbrev-commit --decorate \
        --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' | \
        sed -E \
            -e 's/\|(\x1b\[[0-9;]*m)+\\(\x1b\[[0-9;]*m)+ /├\1─╮\2/' \
            -e 's/(\x1b\[[0-9;]+m)\|\x1b\[m\1\/\x1b\[m /\1├─╯\x1b\[m/' \
            -e 's/\|(\x1b\[[0-9;]*m)+\\(\x1b\[[0-9;]*m)+/├\1╮\2/' \
            -e 's/(\x1b\[[0-9;]+m)\|\x1b\[m\1\/\x1b\[m/\1├╯\x1b\[m/' \
            -e 's/╮(\x1b\[[0-9;]*m)+\\/╮\1╰╮/' \
            -e 's/╯(\x1b\[[0-9;]*m)+\//╯\1╭╯/' \
            -e 's/(\||\\)\x1b\[m   (\x1b\[[0-9;]*m)/╰╮\2/' \
            -e 's/(\x1b\[[0-9;]*m)\\/\1╮/g' \
            -e 's/(\x1b\[[0-9;]*m)\//\1╯/g' \
            -e 's/^\*|(\x1b\[m )\*/\1⎬/g' \
            -e 's/(\x1b\[[0-9;]*m)\|/\1│/g' \
        | command less -r +'/[^/]HEAD'
    setterm -linewrap on
}

# 加载 powerlevel10k 主题
zi ice depth=1
zi light romkatv/powerlevel10k

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
