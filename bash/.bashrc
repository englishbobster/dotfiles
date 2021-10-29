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
export HISTCONTROL=ignoreboth:erasedups
export HISTTIMEFORMAT="%y%m%d:%T "
export HISTSIZE=-1
export HISTFILESIZE=-1


#default editor
export VISUAL=emacs
export EDITOR="$VISUAL"

JAVA_HOME=$(update-alternatives --query java | grep Value: | awk -F'Value: ' '{print $2}' | awk -F'/bin/java' '{print $1}')

#XWIN for WSL2
if command -v "wsl.exe" &> /dev/null; then
    echo "setting up xwin env for WSL"
    export WSL_ip_line=$(ipconfig.exe | grep "WSL" -n | awk -F ":" '{print $1+4}')
    export DISPLAY=$(ipconfig.exe | awk -v a=$WSL_ip_line '{if (NR==a) print $NF":0.0"}' | tr -d "\r")
    export LIBGL_ALWAYS_INDIRECT=1
fi

#history for erlang and elixir shells
export ERL_AFLAGS="-kernel shell_history enabled"

# make less friendly for non-text input files, see lesspipe(1)
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
LOCAL_GRADLE=~/src/local_apps/local_gradle/gradle/bin
SPRING_HOME=~/src/local_apps/spring

#path
export PATH=$PATH:$LINKS:$LOCALAPPS
export PATH=$PATH:/usr/local/go/bin
export PATH=$HOME/.local/bin:$PATH

#some useful paths
SRC_HOME=/home/stos/src
REPOS=$SRC_HOME/dev/repos

function add_ssh_keys {
    eval "$(ssh-agent -s)"
    for file in `find ~/.ssh -type f -name "id*" -not \( -name "*.pub" \)`
    do
        ssh-add $file
    done
}

function fix_intellij {
    dir=$(pwd)
    if [ -d ".idea/" ]; then
	rm -rf .idea/
	for i in $(find $dir -name "*.iml")
	do
	    rm $i
	done	
    else
	echo "not a intellij project"
    fi
}


alias keyme="add_ssh_keys"

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

if [ -f ~/.bash_alias_work ]; then
    . ~/.bash_alias_work
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


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/stos/src/local_apps/google-cloud-sdk/path.bash.inc' ]; then . '/home/stos/src/local_apps/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/stos/src/local_apps/google-cloud-sdk/completion.bash.inc' ]; then . '/home/stos/src/local_apps/google-cloud-sdk/completion.bash.inc'; fi
source <(kubectl completion bash)

complete -C /usr/bin/terraform terraform
