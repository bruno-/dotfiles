[ -s "$HOME/data/src/private_dotfiles/secrets" ] && source "$HOME/data/src/private_dotfiles/secrets"

# Bash completion
export BASH_COMPLETION_COMPAT_DIR="/usr/local/etc/bash_completion.d"
if [ -f /usr/local/etc/profile.d/bash_completion.sh ]; then
  source /usr/local/etc/profile.d/bash_completion.sh 2>/dev/null
fi

# Bash prompt
function _exists() { command -v $1 > /dev/null 2>&1; echo "$(( !$? ))"; }
# \W - working dir, $(..) - git branch with colors, \$ - # for root
if [[ $(_exists __git_ps1) -ne 0 ]]; then
  # green: \033[0;32m
  # resets to default: \033[m
  PS1='\[\033k\033\\\]\W\[\033[0;32m\]$(__git_ps1 "*%s")\[\033[m\] \$ '
else  # fallback when __git_ps1 is not defined
  PS1='\W \$ '
fi

# Rbenv
if [ -d $HOME/.rbenv ]; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi

# NVM
source_nvm() {
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
}

# Bash history
export HISTFILE="$HOME/data/var/log/bash_history"
export HISTSIZE=100000           # expands history size
export HISTFILESIZE=100000
# ignoredups:ignorespace - ignores double commands and those that begin with space
export HISTCONTROL=ignoreboth
export GREP_OPTIONS="--color=auto"
export LESS='--RAW-CONTROL-CHARS --LONG-PROMPT --IGNORE-CASE --no-init'
export LESSHISTFILE="-"
export GOPATH="$HOME/go"
export WEECHAT_HOME="$HOME/data/var/weechat"
export IRBRC="$HOME/data/src/dotfiles/irbrc"
export PRYRC="$HOME/data/src/dotfiles/pryrc"
export INPUTRC="$HOME/data/src/dotfiles/inputrc"
export DISABLE_SPRING=true
export TIMEWARRIORDB="$HOME/data/var/timewarrior"
export TASKRC="$HOME/data/src/dotfiles/taskrc"
export DOTREMINDERS="$HOME/data/var/reminders"
export BUNDLE_USER_HOME="/tmp/bundle"
export CTAGS="--options=$HOME/data/src/dotfiles/ctags"
export GNUPGHOME="$HOME/data/src/private_dotfiles/gnupg"
export XDG_CONFIG_HOME="$HOME/.config"
# GPG agent
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
export GPG_TTY=$(tty)
gpgconf --launch gpg-agent

# command for execute before PS1 is printed
# history -a writes to bash hist file as soon as command is executed
export PROMPT_COMMAND='history -a;echo -ne "\033]0;${PWD/#$HOME/~}\007"'
export EDITOR='vim'
export PAGER='less'
export CLICOLOR=1 # colorize 'ls'
export RI="--format ansi" # ri has color output
MY_PREFIX=$HOME/src # path for custom compiled software
export PATH=/usr/local/share/npm/bin:$PATH:$HOME/data/bin:$MY_PREFIX/bin
export PKG_CONFIG_PATH=$MY_PREFIX/lib/pkgconfig   # pkg-config additional path
unset MAILCHECK
export SURFRAW_text_browser=links
export SURFRAW_graphical=no

# Bash options
bind 'set bell-style none' 2>/dev/null # disable shell (visual) bell
stty werase undef 2>/dev/null # setting this enables better readline Ctrl-W
stty -ixon -ixoff 2>/dev/null # Ctrl-S can be used as an opposite to Ctrl-R (necessary in bash)

alias mv='mv -i'
alias cp='cp -i'
alias sidekiq='STUB_RPC=true bundle exec sidekiq -e development -r . -c 1 critical default low mailer scheduled'
