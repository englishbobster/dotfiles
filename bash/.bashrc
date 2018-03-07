#oki...need to cater for multiple linux environments
#find the linux OS and then use this to activate particulars for the correct os
os="unknown"
if type lsb_release > /dev/null 2>&1; then
    os=$(lsb_release -si)
elif [ -f /etc/os-release ]; then
    . /etc/os-release
    os=$NAME
fi

#check the shell options $- and see if we are interactive
# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

#history options
shopt -s histappend
HISTCONTROL=ignoreboth
export HISTTIMEFORMAT="%y%m%d:%T "
export HISTSIZE=-1
export HISTFILESIZE=-1

#history for erlang and elixir shells
export ERL_AFLAGS="-kernel shell_history enabled"

# make less more friendly for non-text input files, see lesspipe(1)
if [ "$os" == "Ubuntu" ]; then
    [ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"
elif [ "$os" == "Gentoo" ]; then
    [ -x /usr/bin/lesspipe ] && export LESSOPEN="|lesspipe %s"
fi

if [ "$os" == "Ubuntu" ]; then
    # set variable identifying the chroot you work in (used in the prompt below)
    if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
        debian_chroot=$(cat /etc/debian_chroot)
    fi
   # If this is an xterm set the title to user@host:dir
    case "$TERM" in
        xterm*|rxvt*)
            PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
            ;;
        *)
            ;;
    esac
fi

# enable color support of ls and also add handy aliases for ubuntu
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

#put symbolic links for use with xmonad here
LINKS=~/.xmonad/links
LOCALAPPS=~/src/local_apps/bin
MIBBROWSER=~/src/local_apps/ireasoning/mibbrowser
LOCAL_GRADLE=~/src/local_apps/local_gradle/gradle/bin
SPRING_HOME=~/src/local_apps/spring

#path
export PATH=$PATH:$LINKS:$LOCALAPPS:$MIBBROWSER:$LOCAL_GRADLE:$SPRING_HOME/bin

#some useful paths
SRC_HOME=/usr/local/src
DEV_HOME=$SRC_HOME/dev
REPOS=$DEV_HOME/repos

#workspace shortcuts
alias tnm="cd $REPOS/nm/tnm/"
alias dev="cd $DEV_HOME"
alias repos="cd $REPOS"

#useful ssh shortcuts (assumes public ssh keys)
#as root
alias 1k='ssh -X root@tnm-load-1k'
alias 5k='ssh -X root@tnm-load-5k'
alias 10k='ssh -X root@tnm-load-10k'
alias reg='ssh -X root@tnm-load-reg'
alias mimic1_root='ssh -X root@tnm-mimic1'
alias mimic2_root='ssh -X root@tnm-mimic2'
alias mimic3_root='ssh -X root@tnm-mimic3'
#as mimic
alias mimic1='ssh -X mimic@tnm-mimic1'
alias mimic2='ssh -X mimic@tnm-mimic2'
alias mimic3='ssh -X mimic@tnm-mimic3'
#other
alias radius='ssh -X tnmuser@172.16.12.13'

#other useful commands
alias lls="ls -altr"
alias emax="emacs -nw"
alias gradle='gradle-wrapper-wrapper'
alias mysqlprompt="mysql -uroot -proot"

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Prompt
# We wang Git repo branch flagged on the prompt
if [ "$os" == "Ubuntu" ]; then
    source /etc/bash_completion.d/git-prompt
elif [ "$os" == "Gentoo" ]; then
    source /usr/share/git/git-prompt.sh
fi
red="\[\033[0;31m\]"
yellow="\[\033[00;33m\]"
blue="\[\033[01;34m\]"
green="\[\033[01;32m\]"
white="\[\033[00m\]"
PS1=$green'\u@\h:'$blue'\w'$yellow'$(__git_ps1 " (%s)")'$white' :> '

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

#THIS MUST BE AT THE END OF THE FILE FOR GVM TO WORK!!!
[[ -s "~/.gvm/bin/gvm-init.sh" ]] && source "~/.gvm/bin/gvm-init.sh"
