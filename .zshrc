# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.

# ==========================
# Startup
# ==========================
fastfetch


if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ==========================
# Auto-attach tmux
# ==========================
if [ -z "$TMUX" ] && [ -z "$VSCODE_PID" ] && [ -z "$ZED_TERM" ]; then
  tmux attach -t main 2>/dev/null || tmux new -s main
fi

# ==========================
# SSH Agent
# ==========================
if [ -z "$SSH_AUTH_SOCK" ]; then
  eval "$(ssh-agent -s)" > /dev/null
  ssh-add ~/.ssh/id_rsa 2>/dev/null
fi

# ==========================
# Terminal Essentials & Aliases
# ==========================
export PATH="$HOME/.local/bin:$HOME/.local/zed.app/bin:$PATH"
export EDITOR=nvim
alias ls='eza --icons=always --color=always'
alias ll='eza -alF --icons=always --color=always'
alias cat='bat'
alias cf-dns='echo -e "nameserver 1.1.1.1\nnameserver 1.0.0.1" | sudo tee /etc/resolv.conf > /dev/null && echo "🚀 DNS berhasil diganti ke Cloudflare!"'


# ==========================
# History
# ==========================
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt SHARE_HISTORY
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt EXTENDED_HISTORY

# ==========================
# Zsh Autocompletion 
# ==========================
autoload -Uz compinit
compinit

# ==========================
# Init Tools
# ==========================
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"

# ==========================
# Plugin Zsh
# ==========================
ZSH_AUTOSUGGEST_USE_ASYNC=
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# ==========================
# Syntax Highlighting (HARUS PALING AKHIR)
# ==========================
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


