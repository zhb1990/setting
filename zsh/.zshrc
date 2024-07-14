# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init --path)"
fi

export VCPKG_ROOT="$HOME/vcpkg"

FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

autoload -Uz compinit && compinit

setopt COMPLETE_IN_WORD

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit

(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk



zinit snippet OMZ::plugins/colored-man-pages/colored-man-pages.plugin.zsh

# Binary release in archive, from GitHub-releases page.
# After automatic unpacking it provides program "fzf".
zinit ice from"gh-r" as"program"
zinit light junegunn/fzf

zinit ice lucid wait='1'
zinit light Aloxaf/fzf-tab

zinit light zsh-users/zsh-completions

# A glance at the new for-syntax – load all of the above
# plugins with a single command. For more information see:
# https://zdharma-continuum.github.io/zinit/wiki/For-Syntax/
zinit for \
    light-mode \
  zsh-users/zsh-autosuggestions \
    light-mode \
  zdharma-continuum/fast-syntax-highlighting \
  zdharma-continuum/history-search-multi-word 

zinit ice depth"1" # git clone depth
zinit light romkatv/powerlevel10k

zinit ice as"program" pick"$ZPFX/bin/git-*" src"etc/git-extras-completion.zsh" make"PREFIX=$ZPFX"
zinit light tj/git-extras
source $HOME/.local/share/zinit/plugins/tj---git-extras/etc/git-extras-completion.zsh

eval "$(zoxide init zsh)"

# 不需要花里胡哨的 ls，我们有更花里胡哨的 eza
alias ls="eza --icons --git"
alias ll="eza -l --icons --git -a"
alias lt="eza --tree --level=2 --long --icons --git"
source /Users/zhb/.local/share/zinit/plugins/tj---git-extras/etc/git-extras-completion.zsh
# 配置 fzf 使用 fd
export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_DEFAULT_OPTS="--height 50% --layout=reverse --preview '(highlight -O ansi {} || cat {}) 2> /dev/null | head -500'"

export PATH=/Users/zhb/dev/depot_tools:/Users/zhb/vcpkg:$PATH
export DEPOT_TOOLS_WIN_TOOLCHAIN=0

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

alias luamake="/Users/zhb/dev/luamake/luamake"

zstyle ":completion:*:descriptions" format "[%d]"
zstyle ":completion:*" list-colors ${(s.:.)LS_COLORS}
zstyle ':fzf-tab:complete:brew-(install|uninstall|search|info):*-argument-rest' fzf-preview 'brew info $word'
# preview directory's content with eza when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
zstyle ':fzf-tab:complete:-command-:*' fzf-flags --height $(( LINES / 3 * 2 ))
zstyle ':fzf-tab:complete:-command-:*' fzf-preview '(out=$(tldr -C "$word") 2>/dev/null && echo $out) || (out=$(MANWIDTH=$FZF_PREVIEW_COLUMNS man "$word") 2>/dev/null && echo $out) || (out=$(which "$word") && echo $out) || echo "${(P)word}"'
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
zstyle ':completion:*' fzf-search-display true
zstyle ":fzf-tab:*" switch-group "ctrl-h" "ctrl-l"


