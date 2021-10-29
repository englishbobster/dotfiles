#shortcuts
alias repos="cd $REPOS"

#cmdline
alias lls="ls -altr"
alias ls_jar="jar -tf"


#tools
alias wacom_main='xsetwacom -v set "Wacom Intuos BT S Pen stylus" MapToOutput HEAD-0'
alias wacom_side='xsetwacom -v set "Wacom Intuos BT S Pen stylus" MapToOutput HEAD-2'


#this will remove all the docker containers that are now defunct
function kill_docker_ps {
	docker kill $(docker ps -aq) && docker rm $(docker ps -aq)
}

alias clear_containers="kill_docker_ps"

#build tools
alias format-code='mvn com.theoryinpractise:googleformatter-maven-plugin:format'
alias format-xml='mvn au.com.acegi:xml-format-maven-plugin:xml-format'
alias gradle='gw'

