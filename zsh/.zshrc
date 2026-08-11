# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"
fpath+=($HOME/.zsh/pure)
ZSH_THEME="robbyrussell"

plugins=(git fast-syntax-highlighting zsh-autosuggestions)



source $ZSH/oh-my-zsh.sh

alias nvlazy="NVIM_APPNAME=nvim-lazyvim nvim"
alias zshconfig="nvim ~/.zshrc"
alias ls="eza -l --icons"
alias lsa="eza -l -a --icons"
alias chwal="~/./changeWallpaper.sh"
alias cursor='~/Applications/cursor.AppImage --no-sandbox'
alias ls='eza --icons'
eval "$(zoxide init zsh)"
bindkey -v
KEYTIMEOUT=1

# opencode
export PATH=/home/raypamber/.opencode/bin:$PATH
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/.npm-global/bin:$PATH"
export PATH="$HOME/.config/emacs/bin:$PATH"
export PATH="$HOME/Applications:$PATH"

export NVM_DIR="$HOME/.nvm"

# Load NVM only when a Node command is actually used, rather than delaying every
# new terminal. The function replaces itself with NVM's real command on first use.
nvm() {
  unset -f nvm node npm npx
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
  nvm "$@"
}
node() { nvm node "$@"; }
npm() { nvm npm "$@"; }
npx() { nvm npx "$@"; }
