# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

#shopt options
setopt GLOB_DOTS  #make sure that hidden files are included in glob searches

# Path to your oh-my-zsh installation.
export ZSH="/Users/stuosb/.oh-my-zsh"

# Set name of the theme to load
ZSH_THEME="agnoster"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history
HIST_STAMPS="%y%m%d:%T"
HISTSIZE=99999
HISTFILESIZE=999999
SAVEHIST=$HISTSIZE

# Which plugins would you like to load?
plugins=(git kubectl gcloud zsh-autosuggestions zsh-syntax-highlighting emacs gh jenv)

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
export PATH="$HOME/.jenv/bin/:$HOME/src/localapps/:$PATH"
eval "$(jenv init -)"

# some useful paths
export SRC_HOME=/Users/stuosb/src
export REPOS=$SRC_HOME/dev/repos
export NORDNET=$REPOS/nordnet
export HODOR=$NORDNET/hodor


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

# ruby and jekyll settings
# this export corrects a move of some rubyf files in later Mac OS releases
export SKDROOT=$(xcrun --show-sdk-path)
#ruby is already preinstalled on mac but we install with brew for the lates version and put that version first on the path
export PATH="/usr/local/opt/ruby/bin:$PATH"
#add gems global location on path
export PATH="/usr/local/lib/ruby/gems/3.0.0/bin:$PATH"
#add gems local location on path
export PATH="$HOME/.local/share/gem/ruby/3.0.0/bin:$PATH"

# some useful aliases
alias keyme="add_ssh_keys"
alias repos="cd $REPOS"
alias nordnet="cd $NORDNET"
alias hodor="cd $HODOR"
alias lls="ls -altr"
alias ls_jar="jar -tf"


# cluster aliases for proxying and switching between clusters
function proxy {
    kubectl port-forward svc/cloudsql-proxy-$1 -n $3 5432:5432 & kubectl port-forward svc/$2 -n $3 8080:8080 8081:8081 && fg
}

alias prod_cluster="gcloud config set project prod-cluster-25354 && kubectl config use-context gke_prod-cluster-25354_europe-north1_main"
alias dev_cluster="gcloud config set project hodor-cluster-30317 && kubectl config use-context gke_hodor-cluster-30317_europe-north1_main"
alias test_cluster="gcloud config set project test-cluster-29260 && kubectl config use-context gke_test-cluster-29260_europe-north1_main"

alias proxy_realisation="proxy realisation realisation-service tax"
alias proxy_report9a="proxy report-9a report-9a-service tax"
alias proxy_transaction_master="proxy transaction-master-postgres-14 transaction-master-service transaction"
alias proxy_position_master="proxy position-master position-master-service holdings"
alias proxy_aml_holdings="proxy aml-holdings aml-holdings-service holdings"

#spin up a local postgres for test
alias postgres_stu_start="docker run --name stus-postgres -p 5432:5432 -v ~/postgres_data:/var/lib/postgresql/data -e POSTGRES_USER=stuosb -e POSTGRES_PASSWORD=stuosb -e POSTGRES_DB=stuosb postgres:latest &> /dev/null &"

function postgres_client  {
    docker run -it \
           --rm postgres \
           psql -h \
           $(docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $1) \
           -U $2
}

alias postgres_client_stu="postgres_client stus-postgres stuosb"

source "/usr/local/opt/kube-ps1/share/kube-ps1.sh"
PROMPT='$(kube_ps1)'$PROMPT

function get_cluster_short() {
  if [[ "$1" == *"prod-cluster"* ]];then
    echo "prod"
  elif [[ "$1" == *"test-cluster"* ]];then
    echo "test"
  fi
}

KUBE_PS1_CLUSTER_FUNCTION=get_cluster_short

#run motd file
~/.motd.sh

# Colima (docker replacement) environment variables for it to work well with Java Testcontainers
if colima status 2> /dev/null ; then
    export TESTCONTAINERS_DOCKER_SOCKET_OVERRIDE=/var/run/docker.sock
    export TESTCONTAINERS_HOST_OVERRIDE=$(colima ls -j | jq -r '.address')
    export DOCKER_HOST="unix://${HOME}/.colima/default/docker.sock"
else
    echo "Colima is not running -- can not set environment variables"
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Created by `pipx` on 2022-11-03 17:37:46
export PATH="$PATH:/Users/stuosb/.local/bin"
