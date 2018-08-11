DockerPrefix=$1
projectname=$2

if [ -z "$DockerPrefix" ] || [ -z "$projectname" ]

then
echo "Two Arguments are required"
echo "1) Docker prefix"
echo "2) Project name"

exit 1

fi


foldername=$(docker exec  $DockerPrefix'_selenium-hub_1' /bin/bash -c 'cd /home/seluser/AutomationProjects && ls|awk 'NR==1 {print $1}' ')
echo "foldernameis" $foldername


#replace jenkins with the username configured to connect with jenkins on the linux VM.
cd /home/jenkins/results
mkdir -p $projectname
cd $projectname
docker cp $DockerPrefix'_selenium-hub_1':/home/seluser/AutomationProjects/$foldername/target/surefire-reports/testng-results.xml .
docker cp $DockerPrefix'_selenium-hub_1':/home/seluser/AutomationProjects/$foldername/finalReport/ .
