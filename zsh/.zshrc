# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/stuosb/.oh-my-zsh"

# Set name of the theme to load
ZSH_THEME="agnoster"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"


HIST_STAMPS="%y%m%d:%T"
HISTSIZE=99999
HISTFILESIZE=999999
SAVEHIST=$HISTSIZE

# Which plugins would you like to load?
plugins=(git kubectl gcloud)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'
else
   export EDITOR='emacs'
fi

# jenv settings
export PATH="$HOME/.jenv/bin/:$PATH"
eval "$(jenv init -)"

# some useful paths
SRC_HOME=/Users/stuosb/src
REPOS=$SRC_HOME/dev/repos
NORDNET=$REPOS/nordnet

# some useful functions
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

# some useful aliases
alias keyme="add_ssh_keys"
alias repos="cd $REPOS"
alias nordnet="cd $NORDNET"
alias lls="ls -altr"
alias ls_jar="jar -tf"

alias prod_cluster="gcloud config set project prod-cluster-25354 && kubectl config use-context gke_prod-cluster-25354_europe-north1_main"
alias dev_cluster="gcloud config set project hodor-dev-cluster-22739 && kubectl config use-context gke_hodor-dev-cluster-22739_europe-north1_main"
alias test_cluster="gcloud config set project test-cluster-29260 && kubectl config use-context gke_test-cluster-29260_europe-north1_main"

alias proxy_transaction_manager="kubectl port-forward svc/cloudsql-proxy-transaction-master -n transaction 5432:5432"


source "/usr/local/opt/kube-ps1/share/kube-ps1.sh"
PROMPT='$(kube_ps1)'$PROMPT

#run motd file
~/.motd.sh
