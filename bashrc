# If not running interactively, don't do anything
[ -z "$PS1" ] && return

alias kta='ps aux | grep "tmux attach" | grep -v "grep" | awk "{print \$2}" | xargs kill -9'
alias ta='kta; tmux attach'
alias hl='hphpd -h localhost'
alias gca='git commit -a --amend -C HEAD'
alias frb='git fetch; git rebase trunk; arc build'

export EDITOR=vim
export PATH=$PATH:~/bin

if [ $TERM = xterm ]
then
  export TERM=xterm-256color
elif [ $TERM = screen ]
then
  export TERM=screen-256color
elif [ $TERM = linux ]
then
  ~/.dotfiles/solarized-linux-console.sh
fi

eval `dircolors ~/.dotfiles/dir_colors`

stty -ixon

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=20000

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ls='ls --color=auto'
alias ll='ls -lh'
alias la='ls -A'
alias l='ls -CF'

# git prompt, if it's available
function branch_ps1() {
  #if [[ `type -t __git_ps1` = function ]]
  #then
  #  __git_ps1 %s
  if [[ -n $(_dotfiles_scm_info) ]];
    then
    # wrap in parens
    echo "$(_dotfiles_scm_info)"
  fi
}

export PS1="\[\e[0;36m\]\u@\h\[\e[m\] \[\e[0;34m\]\w\[\e[m\] \[\e[0;33m\]\$(branch_ps1)\[\e[m\]\$ "

# fixing ssh-agent issues in tmux
function fixauth() {
  if [[ -n $TMUX ]]; then
    #TMUX gotta love it
    eval $(tmux showenv | grep -vE "^-" | awk -F = '{print "export "$1"=\""$2"\""}')
  fi
}

# hook for preexec
preexec () { fixauth; }
preexec_invoke_exec () {
      [ -n "$COMP_LINE" ] && return  # do nothing if completing
          local this_command=`history 1 | sed -e "s/^[ ]*[0-9]*[ ]*//g"`;
              preexec "$this_command"
}
trap 'preexec_invoke_exec' DEBUG

# Load settings specific to this machine.
local_bashrc=~/.bashrc.local
if [ -e "$local_bashrc" ]
then
  source "$local_bashrc"
fi

# load git completion
git_completion=~/.git-completion.bash
source "$git_completion"

hg_path=~/.hg-prompt
source "$hg_path"

hg_completion=/opt/fbhg/etc/bash_completion.d/mercurial.sh
if [[ -r $hg_completion ]]; then
  source $hg_completion
fi

PERL_MB_OPT="--install_base \"/home/longinoa/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/longinoa/perl5"; export PERL_MM_OPT;

# Fix tmux and bash_histor
# avoid duplicates..
export HISTCONTROL=ignoredups:erasedups

# append history entries..
shopt -s histappend

# After each command, save and reload history
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

function getjobs() {
  val="${1//\./\\\.}"
  adb shell dumpsys jobscheduler | sed -n -e "/JOB.*$val/,/Ready/ p"
}
