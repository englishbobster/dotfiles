#shortcuts
alias repos="cd $REPOS"
alias PSR3="cd $REPOS/pricer/pricer-server-r3server"

#cmdline
alias lls="ls -altr"
alias ls_jar="jar -tf"

#docker
alias mysql_start="docker run --name pricer_mysql -e MYSQL_ROOT_HOST=% -e MYSQL_ROOT_PASSWORD=v1ndal00 -e MYSQL_PASSWORD=PRICER -e MYSQL_USER=PRICER -e MYSQL_DATABASE=PRICER -p 7799:3306 -d mysql:5.7.32"
alias mysql_stop="docker stop pricer_mysql"	
alias mysql_remove="docker rm pricer_mysql"

function kill_docker_ps {
	docker kill $(docker ps -aq) && docker rm $(docker ps -aq)
}
alias clear_containers="kill_docker_ps"
#build tools
alias mcis='mvn clean install -DskipTests -Dcheckstyle.skip=true -Dmaven.javadoc.skip=true -Dpmd.skip=true -Dfindbugs.skip=true $@'
