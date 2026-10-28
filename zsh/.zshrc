# If you come from bash you might have to change your $PATH.
PATH_HUGGING=/Library/Frameworks/Python.framework/Versions/3.11/bin
export PATH=$PATH_HUGGING:$HOME/bin:/usr/local/bin:$PATH

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
plugins=(git kubectl gcloud zsh-autosuggestions zsh-syntax-highlighting emacs gh kube-ps1)

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

# some useful paths
export SRC_HOME=/Users/stuosb/src
export REPOS=$SRC_HOME/dev/repos
export NORDNET=$REPOS/nordnet
export FAB=$NORDNET/fab
export FAB_NNX=$FAB/nnx
export FAB_ONPREM=$FAB/on-prem
export FAB_SHARED=$FAB/shared
export OTHER=$NORDNET/other
export OTHER_NNX=$OTHER/nnx
export OTHER_ONPREM=$OTHER/on-prem
export OTHER_SHARED=$OTHER/shared


export ANTHROPIC_BASE_URL=https://llm-gateway.productivity.nordnettech.se
# secrets (e.g. ANTHROPIC_AUTH_TOKEN) live in ~/.zshrc.local, outside this repo
[ -f ~/.zshrc.local ] && source ~/.zshrc.local
export CLAUDE_CODE_ENABLE_GATEWAY_MODEL_DISCOVERY=1
export CLAUDE_CODE_USE_VERTEX=0



# some useful functions

# requests PAM on the active cluster's project (choose it first with prod_cluster/test_cluster)
function pamg {
  if [ -z "$2" ]; then
    echo "Error: Justification is missing." >&2
    return 1
  fi
  local project=$(gcloud config get-value project 2>/dev/null)
  case "$project" in
    prod-cluster-25354|test-cluster-29260) ;;
    *) echo "Error: active project '$project' is not prod or test. Run prod_cluster or test_cluster first." >&2
       return 1 ;;
  esac
  echo "Requesting '$1' on $project"
  gcloud alpha pam grants create \
    --entitlement="$1" \
    --requested-duration="14400s" \
    --justification="$2" \
    --location="global" \
    --project="$project"
}

function add_ssh_keys {
    eval "$(ssh-agent -s)"
    for file in `find ~/.ssh -type f -name "id*" -not \( -name "*.pub" \)`
    do
        ssh-add $file
    done
}

function make_uuid {
   uuidgen | tr "[:upper:]" "[:lower:]" | tr -d '\n' | pbcopy
}

# one ssh_agent to rule them all (all the terminals)
export SSH_AUTH_SOCK=~/.ssh/auth_sock
if ! fuser "$SSH_AUTH_SOCK" >/dev/null 2>/dev/null; then
  # Nothing has the socket open, it means the agent isn't running
  ssh-agent -a "$SSH_AUTH_SOCK" -s >~/.ssh/agent-info
  for file in `find ~/.ssh -type f -name "id*" -not \( -name "*.pub" \)`
  do
      ssh-add $file
      echo "added ${file}"
  done
fi

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

function gcp_login {
  if gcloud auth print-access-token &>/dev/null; then
    echo "Already logged in to gcloud. Just refreshing the access token..."
    npx --registry=https://registry.npmjs.org google-artifactregistry-auth
  else
    echo "Not logged in to gcloud. Running full login process..."
    gcloud auth login --update-adc && npx --registry=https://registry.npmjs.org google-artifactregistry-auth
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
# dont forget to end in single space on pamg aliases
alias pam_pubsub="pamg pubsub-project-access "
alias pam_cluster="pamg cluster-access "
alias pam_bigtable_admin="pamg bigtable-admin "
alias pam_bigtable_user="pamg bigtable-user "
alias pam_bucket="pamg bucket-project-access "
alias restart_feemachine="kubectl rollout restart deployment fee-machine-deployment -n fee-and-billing"
alias master="git checkout master"
alias uuid_please="make_uuid"
alias keyme="add_ssh_keys"
alias repos="cd $REPOS"
alias nordnet="cd $NORDNET"
alias fab="cd $FAB"
alias fab_nnx="cd $FAB_NNX"
alias fab_onprem="cd $FAB_ONPREM"
alias fab_shared="cd $FAB_SHARED"
alias other="cd $OTHER"
alias other_nnx="cd $OTHER_NNX"
alias other_onprem="cd $OTHER_ONPREM"
alias other_shared="cd $OTHER_SHARED"
alias lls="ls -altr"
alias ls_jar="jar -tf"
alias goog="gcp_login"
alias update_brew="brew update && brew outdated --greedy && brew upgrade --greedy && brew cleanup"

# cluster aliases for proxying and switching between clusters
function proxy {
    kubectl port-forward svc/cloudsql-proxy-$1 -n $3 5432:5432 & kubectl port-forward svc/$2 -n $3 8080:8080 8081:8081 && fg
}

function proxy_new {
    kubectl port-forward svc/$1-cloudsql-proxy -n $3 5432:5432 & kubectl port-forward svc/$2 -n $3 8080:8080 8081:8081 && fg
}


alias prod_cluster="gcloud config set project prod-cluster-25354 && kubectl config use-context gke_prod-cluster-25354_europe-north1_main"
alias test_cluster="gcloud config set project test-cluster-29260 && kubectl config use-context gke_test-cluster-29260_europe-north1_main"

alias proxy_sip="proxy sip-fee sip-fee-service fee-and-billing"
alias proxy_fee_decider="proxy_new fee-decider fee-decider-service fee-and-billing"
alias proxy_refunder_holding="proxy_new refunder-holding refunder-holding-service fee-and-billing"
alias proxy_refunder_transaction="proxy_new refunder-transaction refunder-transaction-service fee-and-billing"
alias proxy_partner_identity="proxy_new partner-identity partner-identity-service fee-and-billing"
alias proxy_fee_machine="proxy_new fee-machine fee-machine-service fee-and-billing"
alias proxy_subscription_master="proxy_new subscription-master subscription-master-service subscription"
alias proxy_fin_ex="proxy_new finansportalen-exporter finansportalen-exporter fee-and-billing"
alias proxy_sectras="proxy_new sectras-statement-orders sectras-statement-orders-service tax"
#spin up a local postgres for test
alias postgres_stu_start="docker run --name stus-postgres -p 5432:5432 -v ~/postgres_data:/var/lib/postgresql -e POSTGRES_USER=stuosb -e POSTGRES_PASSWORD=stuosb -e POSTGRES_DB=stuosb postgres:latest &> /dev/null &"

function postgres_client  {
    docker run -it \
           --rm postgres \
           psql -h \
           $(docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $1) \
           -U $2
}

alias postgres_client_stu="postgres_client stus-postgres stuosb"

PROMPT='$(kube_ps1)'$PROMPT

function get_cluster_short() {
  if [[ "$1" == *"prod-cluster"* ]];then
    echo "prod"
  elif [[ "$1" == *"test-cluster"* ]];then
    echo "test"
  else
    echo "other"
  fi
}

KUBE_PS1_CLUSTER_FUNCTION=get_cluster_short

#run motd file
~/.motd.sh

# Colima (docker replacement) environment variables for it to work well with Java Testcontainers
if colima status 2> /dev/null ; then
    export TESTCONTAINERS_DOCKER_SOCKET_OVERRIDE=/var/run/docker.sock
    export DOCKER_HOST="unix://${HOME}/.colima/default/docker.sock"
    # Only trust the VM address if it is actually routable. GlobalProtect blackholes
    # the vmnet subnet, and colima's ssh portForwarder publishes ports on localhost anyway.
    colima_address=$(colima ls -j | jq -r '.address')
    if [ -n "$colima_address" ] && nc -z -G 1 "$colima_address" 22 2> /dev/null ; then
        export TESTCONTAINERS_HOST_OVERRIDE=$colima_address
    else
        unset TESTCONTAINERS_HOST_OVERRIDE
    fi
    unset colima_address
else
    echo "Colima is not running -- can not set environment variables"
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Created by `pipx` on 2022-11-03 17:37:46
export PATH="$PATH:/Users/stuosb/.local/bin"

export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
export DOCKER_API_VERSION=1.43

# Tint Ghostty background dark brown while claude is running
claude() {
  printf '\e]11;#1f1812\a'
  command claude "$@"
  local ret=$?
  printf '\e]111\a'
  return $ret
}

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
