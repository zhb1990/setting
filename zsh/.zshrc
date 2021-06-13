# Created by newuser for 5.8

### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-rust \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-bin-gem-node

### End of Zinit's installer chunk

# 快速目录跳转
zinit ice lucid wait='1'
zinit light skywind3000/z.lua

# 语法高亮
zinit ice lucid wait='0' atinit='zpcompinit'
zinit light zdharma/fast-syntax-highlighting

# 自动建议
zinit ice lucid wait="0" atload='_zsh_autosuggest_start'
zinit light zsh-users/zsh-autosuggestions

# 补全
zinit ice lucid wait='0'
zinit light zsh-users/zsh-completions

zinit ice lucid wait='0'
zinit load zdharma/history-search-multi-word

# 加载 OMZ 框架及部分插件
zinit snippet OMZ::lib/completion.zsh
zinit snippet OMZ::lib/history.zsh
zinit snippet OMZ::lib/key-bindings.zsh
zinit snippet OMZ::lib/theme-and-appearance.zsh
zinit snippet OMZ::plugins/colored-man-pages/colored-man-pages.plugin.zsh
zinit snippet OMZ::plugins/sudo/sudo.plugin.zsh

zinit snippet OMZ::plugins/extract

zinit ice lucid wait='1'
zinit snippet OMZ::plugins/git/git.plugin.zsh

# ---- (可选)加载了一堆二进制程序 ----
zinit light zinit-zsh/z-a-bin-gem-node
zinit as="null" wait="1" lucid from="gh-r" for \
    mv="exa* -> exa" sbin="bin/exa"       ogham/exa \
    mv="*/rg -> rg"  sbin		BurntSushi/ripgrep \
    mv="fd* -> fd"   sbin="fd/fd"  @sharkdp/fd \
    sbin="fzf"       junegunn/fzf-bin

# 加载它们的补全等
zinit ice mv="*.zsh -> _fzf" as="completion"
zinit snippet 'https://github.com/junegunn/fzf/blob/master/shell/completion.zsh'
zinit snippet 'https://github.com/junegunn/fzf/blob/master/shell/key-bindings.zsh'
zinit ice as="completion"
zinit snippet 'https://github.com/robbyrussell/oh-my-zsh/blob/master/plugins/fd/_fd'
zinit ice as="completion"
zinit snippet 'https://github.com/ogham/exa/tree/master/completions/zsh/_exa'

# 不需要花里胡哨的 ls，我们有更花里胡哨的 exa
DISABLE_LS_COLORS=true
alias ls=exa
# 配置 fzf 使用 fd
export FZF_DEFAULT_COMMAND='fd --type f'
# ---- 加载完了 ----

export RUSTUP_DIST_SERVER='https://mirrors.ustc.edu.cn/rust-static'
export RUSTUP_UPDATE_ROOT='https://mirrors.ustc.edu.cn/rust-static/rustup'
export PATH=$PATH:"$HOME/.local/bin"

# 加载 powerlevel10k 主题
#zinit ice depth=1
#zinit light romkatv/powerlevel10k
