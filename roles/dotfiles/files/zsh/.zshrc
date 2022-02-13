# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# History settings
HISTFILE="${XDG_DATA_HOME}/zsh/history"
HISTSIZE=2000
SAVEHIST=2000

# Include
[ -f "${ZDOTDIR}/aliasrc" ] && source "${ZDOTDIR}/aliasrc"
[ -f "${ZDOTDIR}/.zkbd" ] && source "${ZDOTDIR}/.zkbd"
[ -f "/usr/share/doc/pkgfile/command-not-found.zsh" ] && source "/usr/share/doc/pkgfile/command-not-found.zsh"

# Shell Options
bindkey -e
set -o SHARE_HISTORY
set -o APPEND_HISTORY
set -o INC_APPEND_HISTORY
set -o HIST_IGNORE_DUPS
set -o HIST_FIND_NO_DUPS
set -o NO_CASE_GLOB
set -o NOBEEP
set -o PROMPT_SUBST

# Load functions
autoload -Uz compinit && compinit # Completion system
autoload -Uz vcs_info # Version control integration
autoload zkbd # inputrc equivalent for zsh

# Version control integration
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
zstyle ':vcs_info:git:*' formats '%F{172}-%u-%c--%b-%f'
zstyle ':vcs_info:git:*' formats '%{%F{172}%}(%25>…>%b%<<)%S%{%f%}%c%u'
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr "%{%F{green}%B%}●%{%b%f%}"
zstyle ':vcs_info:*' unstagedstr "%{%F{red}%B%}●%{%b%f%}"

# Case insensitive path-completion 
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'

# Use zkbd bindings
[ -n ${key[Delete]} ] && bindkey "${key[Delete]}" delete-char
[ -n ${key[Insert]} ] && bindkey "${key[Insert]}" overwrite-mode # not working
[ -n ${key[Home]} ] && bindkey "${key[Home]}" beginning-of-line
[ -n ${key[End]} ] && bindkey "${key[End]}" end-of-line
[ -n ${key[PageUp]} ] && bindkey "${key[PageUp]}" up-line-or-history
[ -n ${key[PageDown]} ] && bindkey "${key[PageDown]}" down-line-or-history
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word

# Change prompt color for remote sessions
#if [ -n "${SSH_CLIENT}" ] || [ -n "${SSH_TTY}" ]; then
#	prompt_color="$(tput smul)$(tput bold)$(tput setaf 46)"
#else
#	prompt_color="$(tput smul)$(tput bold)$(tput setaf 45)"
#fi
#export PS1='\['${prompt_color}'\]--$PWD->\[$(tput sgr0)\]'
#unset prompt_color

PROMPT="%B%F{172}%~(%(?.%F{green}√.%F{red}%?)%f%B%F{172})>%f%b"
RPROMPT="\$vcs_info_msg_0_"

# Syntax highlighting
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[path]='fg=cyan,bold'
ZSH_HIGHLIGHT_STYLES[path_prefix]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]='fg=magenta,bold'
ZSH_HIGHLIGHT_STYLES[alias]='fg=cyan,bold'
[ -f "/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ] && source "/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
