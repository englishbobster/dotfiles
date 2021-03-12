#shortcuts
alias repos="cd $REPOS"
alias PSR3="cd $REPOS/pricer/pricer-server-r3server"

#cmdline
alias lls="ls -altr"
alias ls_jar="jar -tf"

#docker
alias mysql_start="docker run --name pricer_mysql -v ~/mysql/config:/etc/mysql/conf.d -v ~/mysql/data:/var/lib/mysql -e MYSQL_ROOT_HOST=% -e MYSQL_ROOT_PASSWORD=v1ndal00 -e MYSQL_PASSWORD=pricer -e MYSQL_USER=pricer -e MYSQL_DATABASE=PRICER -p 7799:3306 -d mysql:5.7.32"
alias mysql_client="mysql -h127.0.0.1 -P 7799 -u pricer -p"
alias mysql_stop="docker stop pricer_mysql"	
alias mysql_remove="docker rm pricer_mysql"

alias vbs_start="docker run -d --name vbs -p 80:8090 -p 4000-4010:4000-4010 docker.pricer.com/pricer/vbs:3.2.5"

#this will remove all the docker containers that are now defunct
function kill_docker_ps {
	docker kill $(docker ps -aq) && docker rm $(docker ps -aq)
}

alias clear_containers="kill_docker_ps"

#build tools
alias build-fast-dep='mvn clean install -Prun-local -DskipTests -Dlicense.ignore -Ddependency-check.skip -Dspotbugs.skip -Ddb.user=pricer -Ddb.pwd=pricer -Ddb.port=7799'

alias build-test='mvn clean install -Dlicense.ignore -Ddependency-check.skip'
alias build-test-all-p='mvn clean install -Dlicense.ignore -Ddependency-check.skip -T1C'
alias build-all-p='mvn clean install -T1C'
alias run-local='mvn clean install -Prun-local -DskipTests -Dlicense.ignore -Ddependency-check.skip -Dcheckstyle.skip -Dspotbugs.skip -Ddb.user=pricer -Ddb.pwd=pricer -Ddb.port=7799 -T1C'
alias format-code='mvn com.theoryinpractise:googleformatter-maven-plugin:format'
alias next-log='mvn se.pricer:logmess-maven-plugin:4.0.1-9e72458:logmess'
alias format-xml='mvn au.com.acegi:xml-format-maven-plugin:xml-format'
alias gradle='gw'

