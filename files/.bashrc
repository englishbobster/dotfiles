#path
export PATH=$PATH:/home/stos/src/software/marathon:/opt/eclipse-sdk-bin-4.2:/opt/gradle/bin:/opt/mysql/bin:/opt/groovy-2.3.3/bin:/opt/Sublime

#more history
export HISTSIZE=10000

#used for emacs as daemon
export ALTERNATE_EDITOR=""

#set the root prompt to something useful (added ":" to be scp compatible)
PS1='\[\033[01;32m\]\u@\h:\[\033[01;34m\]\w\$\[\033[00m\] '

#some useful paths
SRC_HOME=/usr/local/src
DEV_HOME=$SRC_HOME/dev
GITDIR=$DEV_HOME/git
WORKSPACE=$DEV_HOME/workspace

#groovyhome
export GROOVY_HOME="/opt/groovy-2.3.3"

#workspace shortcuts
alias tnm="cd $DEV_HOME/git/nm/tnm/"
alias dev="cd $DEV_HOME"
alias gitdir="cd $GITDIR"
alias workspace="cd $WORKSPACE"
alias docs_stu="cd $SRC_HOME/Docs/"
alias docs_files="cd /files/docs/"

#useful ssh shortcuts (assumes public ssh keys)
#as root
alias fozzie='ssh -X root@tnm-load-fozzie'
alias gonzo='ssh -X root@tnm-load-gonzo'
alias jenkins='ssh -X root@tnmbuild'
alias yuffie='ssh -X root@tnm-load-yuffie'
alias sephiroth='ssh -X root@tnm-load-sephiroth'
alias mimic1_root='ssh -X root@tnm-mimic1'
alias mimic2_root='ssh -X root@tnm-mimic2'
alias mimic3_root='ssh -X root@tnm-mimic3'
alias irc='ssh stos@irc'
#as mimic
alias mimic1='ssh -X mimic@tnm-mimic1'
alias mimic2='ssh -X mimic@tnm-mimic2'
alias mimic3='ssh -X mimic@tnm-mimic3'
#as stos
alias devsrv='ssh -X stos@devsrv'
alias svnsrv='ssh -X stos@svn'

#other
alias radius='ssh -X tnmuser@172.16.12.13'
alias tnmdocker='ssh -X stos@tnm-docker'

#mysql login
alias mysqlprompt="mysql -uroot -proot"

#other useful commands
alias lls="ls -altr"
alias emax="emacs -nw"
alias gradle='gradle-wrapper-wrapper'
alias knopflerfish-console="$DEV_HOME/misc/knopflerfish-console-kbd-fix telnet -e^c localhost 1622"
alias confd-console='ssh admin@localhost -p 2024'
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

#give me tmux always <3 tmux love <3
#if which tmux 2>&1 >/dev/null; then
     # if no session is started, start a new session
#     [[ -z ${TMUX} ]] && (tmux attach || tmux new-session)
#fi

# Git prompt
source ~/.bash_completion.d/git-prompt
red="\[\033[0;31m\]"
yellow="\[\033[00;33m\]"
blue="\[\033[01;34m\]"
green="\[\033[01;32m\]"
white="\[\033[00m\]"
PS1=$green'\u@\h'$blue' \w'$yellow'$(__git_ps1 " (%s)")'$white' \$ '


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
