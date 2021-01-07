#cmdline
alias lls="ls -altr"

#docker
alias mysql_start="docker run --name pricer_mysql -e MYSQL_ROOT_PASSWORD=pricer -e MYSQL_PASSWORD=pricer -e MYSQL_USER=pricer -p 3306:7799 -d mysql:latest"
alias mysql_stop="docker stop pricer_mysql"	
alias mysql_remove="docker rm pricer_mysql"

function kill_docker_ps {
	docker kill $(docker ps -aq) && docker rm $(docker ps -aq)
}
alias clear_containers="kill_docker_ps"
#build tools
alias mcis='mvn clean install -DskipTests -Dcheckstyle.skip=true -Dmaven.javadoc.skip=true -Dpmd.skip=true -Dfindbugs.skip=true $@'
