
function vundle_plugins() {
  if [[ -d ~/.vim/bundle/Vundle.vim && ! -d ~/.vim/bundle/Zenburn ]]; then
    $1 +PluginInstall +qall  
  fi
}

# Install stuff if not present
case "$OSTYPE" in
  darwin*)
    VIM="/usr/bin/vim"
    vundle_plugins ${VIM}
  ;;
  linux*)
    VIM="/usr/bin/vim"
    vundle_plugins ${VIM}
  ;;
  dragonfly*|freebsd*|netbsd*|openbsd*)
    VIM="/usr/bin/vim"
    vundle_plugins ${VIM}
  ;;
  default)
    echo "Unfamiliar with ${OSTYPE} - edit .zshrc file."
  ;;
esac

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="agnoster"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"
#

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# shellcheck disable=SC2034
plugins=(git ruby github git-remote-branch vagrant golang docker aws terraform)

[[ -s "$ZSH/oh-my-zsh.sh" ]] && source "$ZSH/oh-my-zsh.sh"  

[[ -x "$(command -v homesick)" ]] && homesick pull --quiet

# Set general path NOTE: clobbers rvm
#export PATH=~/.local/bin:~/.bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH

# prepend stuff to path if it exists
if [ -d /usr/local/lib/python3.7/bin ]; then
  export PATH=/usr/local/lib/python3.7/bin:$PATH
fi

if [ -d ~/Library/Python/3.7/bin ]; then                                    
  export PATH=~/Library/Python/3.7/bin:$PATH                                
fi 

if [ -d /usr/local/opt/go/libexec/bin ]; then
  export PATH=/usr/local/opt/go/libexec/bin:$PATH
fi

[[ -s "/usr/share/rvm/scripts/rvm" ]] && source "/usr/share/rvm/scripts/rvm"
[[ -s "/usr/local/rvm/scripts/rvm" ]] && source "/usr/local/rvm/scripts/rvm"

# shell options
set -o vi
set editing-mode vi
bindkey -v
set blink-matching-paren on

# aliases
alias tmux="tmux -2"
alias tns="tmux new -s"
alias ta="tmux attach"
alias tks='tmux kill-session -t'
alias busybox='kubectl run -i --rm --tty debug --image=busybox --restart=Never -- sh'
alias decrypt='gpg -d'
alias 'gi'='gem install --no-ri --no-rdoc --verbose'
alias psp='pry --simple-prompt'
alias vrnp='vagrant reload --no-provision'
alias vunp='vagrant up --no-provision'
alias vs='vagrant status'
alias vu='vagrant up'
alias untar='tar xvf'
alias vssh='vagrant ssh'
alias fixvbox='sudo /Library/StartupItems/VirtualBox/VirtualBox restart'
alias vsr='vs |grep running'
alias vbs='vagrant suspend'
alias vbr='vagrant resume'
alias ccat='pygmentize -g'
alias rlibmodule='export RUBYLIB="$(pwd)"/lib:$RUBYLIB'
alias serverme='mosh --server=/usr/bin/mosh-server serverbot'
alias be='bundle exec'
alias grph='git rev-parse HEAD'
alias de='dotenv'
alias gs='git status'
alias cleanprod='git fetch origin production && git checkout production && git reset --hard origin/production'
alias oa='open -a'
alias tr='gtr'
alias cut='gcut'
alias prune_puppet_branches="git branch | grep -v 'production' |grep -v -F '*' | xargs git branch -D"
alias vmdhcp='sudo /Applications/VMware\ Fusion.app/Contents/Library/vmnet-cli --stop; sudo /Applications/VMware\ Fusion.app/Contents/Library/vmnet-cli --configure; sudo /Applications/VMware\ Fusion.app/Contents/Library/vmnet-cli --start'
#alias pbcopy='xsel --clipboard --input'
#alias pbpaste='xsel --clipboard --output'

#vars
export EDITOR='vim'
export VAGRANT_DEFAULT_PROVIDER=virtualbox

# Specify AWS credentials to use
if [ -f ~/.aws/credentials ]; then
  export AWS_PROFILE=cynerge
fi

if [ -f /usr/local/opt/curl-ca-bundle/share/ca-bundle.crt ]; then
  export SSL_CERT_FILE=/usr/local/opt/curl-ca-bundle/share/ca-bundle.crt
fi

if [ -f /usr/local/bin/gsed ]; then
  alias fixlogs='gsed -r -i.bak "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g"'
fi

# ruby -ryaml -e "YAML.load_file 'tst.yaml'"
validateyaml() {
  ruby -ryaml -rpuppet -e "YAML.load_file '$1'"
}

decryptfile() {
  gpg --decrypt $1 > $1.tar.gz
}

vdf() {
  vagrant destroy $1 --force
}

vuf() {
  vagrant up $1 --provider=vmware_fusion
}

vuv() {
  vagrant up $1 --provider=virtualbox
}

vudo() {
  vagrant up $1 --provider=digital_ocean
}

abt() {
  aws ec2 describe-instances --filters "Name=tag:Name,Values=$1" | jq .
}

findsubnet() {
  abt $1 | jq '.["Reservations"][0]["Instances"][0]["SubnetId"]'
}

findsecg() {
  abt $1 | jq '.["Reservations"][0]["Instances"][0]["SecurityGroups"]'
}

runon() {
  ssh $1 -- TERM=xterm $2
}

alias vgems='GEM_HOME=~/.vagrant.d/gems /Applications/Vagrant/embedded/bin/gem list'

set -o vi
alias crontab="VIM_CRONTAB=true crontab"
export WINEARCH=win32

if [ -e ~/.local/bin/powerline-config ]; then
  export POWERLINE_CONFIG_COMMAND='~/.local/bin/powerline-config'
fi

if [ -e ~/Library/Python/2.7/bin/powerline-config ]; then
  export POWERLINE_CONFIG_COMMAND='~/Library/Python/2.7/bin/powerline-config'
fi

if [ -e ~/.zshrc_secret ]; then
  source ~/.zshrc_secret
fi

if [ -e ~/.zshrc_python ]; then
  source ~/.zshrc_python
fi

if [ -e ~/.zshrc_womply ]; then
  source ~/.zshrc_womply
fi

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

test -e "/usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlightling.zsh" && source "/usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
test -e "/usr/share/zsh-syntax-highlighting/zsh-syntax-highlightling.zsh" && source "/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
