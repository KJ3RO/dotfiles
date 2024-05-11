# CodeWhisperer pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/codewhisperer/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/codewhisperer/shell/zshrc.pre.zsh"
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export PATH="$HOME/.config/emacs/bin:$PATH"
export ZSH="$HOME/.oh-my-zsh"

# ZSH_THEME="powerlevel10k/powerlevel10k"
ZSH_THEME="minimal"
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

ENABLE_CORRECTION="true"

plugins=(
	git 
	zsh-syntax-highlighting 
	zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# User configuration

# ALIASES
alias ga="git add"
alias gaa="git add ."
alias gaaa="git add -A"
alias gs="git status"
alias td="tmux detach"
alias tns="tmux new -s"
alias tl="tmux ls"
alias ta="tmux attach -t"
alias conf="cd ~/.config/ && nvim ."

alias ls="eza --color=always --git --no-filesize --icons=always --no-time --no-user --no-permissions"

alias ll="eza --color=always --long --git --icons=always" 

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export BAT_THEME="Nord"

PATH=~/.console-ninja/.bin:$PATH

# CodeWhisperer post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/codewhisperer/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/codewhisperer/shell/zshrc.post.zsh"

export PATH=$PATH:/Users/doyeon/.spicetify

# --- setup fzf theme ---
fg="#d8dee9"
bg="#2e3440"
bg_highlight="#434c5e"
purple="#b48ead"
blue="#5e81ac"
cyan="#8fbcbb"

export FZF_DEFAULT_OPTS="--color=fg:${fg},bg:${bg},hl:${purple},fg+:${fg},bg+:${bg_highlight},hl+:${purple},info:${blue},prompt:${cyan},pointer:${cyan},marker:${cyan},spinner:${cyan},header:${cyan}"

eval "$(fzf --zsh)"
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"
