#options
shopt -s histappend

#put symbolic links for use with xmonad here
LINKS=~/.xmonad/links
LOCALAPPS=~/src/local_apps/bin
MIBBROWSER=~/src/local_apps/ireasoning/mibbrowser
LOCAL_GRADLE=~/src/local_apps/local_gradle/gradle/bin
SPRING_HOME=~/src/local_apps/spring

#path
export PATH=$PATH:~/src/dev/workspace/Elm-Platform/-1.15.1/.cabal-sandbox/bin:$LINKS:$LOCALAPPS:$MIBBROWSER:$LOCAL_GRADLE:$SPRING_HOME/bin

#some useful paths
SRC_HOME=/usr/local/src
DEV_HOME=$SRC_HOME/dev
GITDIR=$DEV_HOME/repos
WORKSPACE=$DEV_HOME/workspace

#more history
export HISTTIMEFORMAT="%y%m%d:%T "
export HISTSIZE=-1
export HISTFILESIZE=-1
#history for erlang and elixir shells
export ERL_AFLAGS="-kernel shell_history enabled"

#used for emacs as daemon
export ALTERNATE_EDITOR=""

#set the root prompt to something useful (added ":" to be scp compatible)
PS1='\[\033[01;32m\]\u@\h:\[\033[01;34m\]\w\$\[\033[00m\] '

#groovyhome
export GROOVY_HOME="/opt/groovy-2.3.3"

#elm home
export ELM_HOME="/usr/lib64/node_modules/elm/share"

#workspace shortcuts
alias tnm="cd $GITDIR/nm/tnm/"
alias dev="cd $DEV_HOME"
alias repos="cd $GITDIR"
alias elix="cd $GITDIR/elixir"
alias workspace="cd $WORKSPACE"
alias docs_stu="cd $SRC_HOME/Docs/"
alias docs_files="cd /files/docs/"

#useful ssh shortcuts (assumes public ssh keys)
#as root
alias 1k='ssh -X root@tnm-load-1k'
alias 5k='ssh -X root@tnm-load-5k'
alias 10k='ssh -X root@tnm-load-10k'
alias jenkins='ssh -X root@tnmbuild'
alias reg='ssh -X root@tnm-load-reg'
alias mimic1_root='ssh -X root@tnm-mimic1'
alias mimic2_root='ssh -X root@tnm-mimic2'
alias mimic3_root='ssh -X root@tnm-mimic3'
#as mimic
alias mimic1='ssh -X mimic@tnm-mimic1'
alias mimic2='ssh -X mimic@tnm-mimic2'
alias mimic3='ssh -X mimic@tnm-mimic3'
#as stos
alias devsrv='ssh -X stos@devsrv'
#other
alias radius='ssh -X tnmuser@172.16.12.13'

#mysql login
alias mysqlprompt="mysql -uroot -proot"

#other useful commands
alias lls="ls -altr"
alias emax="emacs -nw"
alias gradle='gradle-wrapper-wrapper'
alias java7='sudo eselect java-vm set system 1'
alias java8='sudo eselect java-vm set system 2'

#to update entire gitdir
updateRepos(){
    for i in `ls`; do  #absolute paths listed here
	pushd $i >/dev/null 2>&1
	if [ -d .git ]  ||  git rev-parse --git-dir > /dev/null 2>&1; then
    	    echo "*******************************************"
	    echo "* pulling from git to directory -> $i"
	    echo "*******************************************"
	    git pull
	    echo -e "\n"
	fi
	popd > /dev/null 2>&1
    done
}


# Git prompt
source ~/.bash_completion.d/git-prompt
red="\[\033[0;31m\]"
yellow="\[\033[00;33m\]"
blue="\[\033[01;34m\]"
green="\[\033[01;32m\]"
white="\[\033[00m\]"
PS1=$green'\u@\h:'$blue'\w'$yellow'$(__git_ps1 " (%s)")'$white' :> '


#java script stuff
#Needed for VELOCITY/KARMA/JASMINE
export CHROME_BIN=/usr/bin/google-chrome-stable

#useful little command
#https://gist.github.com/jacksonp/9c2f547434b7d78d1b62#file-explain-sh
explain () {
  if [ "$#" -eq 0 ]; then
    while read  -p "Command: " cmd; do
      curl -Gs "https://www.mankier.com/api/explain/?cols="$(tput cols) --data-urlencode "q=$cmd"
    done
    echo "Bye!"
  elif [ "$#" -eq 1 ]; then
    curl -Gs "https://www.mankier.com/api/explain/?cols="$(tput cols) --data-urlencode "q=$1"
  else
    echo "Usage"
    echo "explain                  interactive mode."
    echo "explain 'cmd -o | ...'   one quoted command to explain it."
  fi
}

# Update 26-03-2015. If using this command gives no output, see if running a simple fetch causes this error:
# $ curl https://www.mankier.com
# curl: (35) Cannot communicate securely with peer: no common encryption algorithm(s).
# If so, try specifying a cipher in the curl commands: curl --ciphers ecdhe_ecdsa_aes_128_sha

#THIS MUST BE AT THE END OF THE FILE FOR GVM TO WORK!!!
[[ -s "/home/stos/.gvm/bin/gvm-init.sh" ]] && source "/home/stos/.gvm/bin/gvm-init.sh"