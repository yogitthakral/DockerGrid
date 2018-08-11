#replace jenkins with the username configured to connect with jenkins on the linux VM.

#take parameters from jenkins,6th argument is framework specific , if not configured in framework , can be deleted from here and if condition. 8th and 9th argument are testlink specific and can be deleted here and from if condition if not using testlink.
NumberOfNodes=$1
DockerPrefix=$2
ymlName=$3
gitRepo=$4
gitBranch=$5
drivertype=$6
environment=$7
projectname=$8
planname=$9


#if block to verify that arguments passed are not null, delete drivertype if not using it inside framework.Delete projectname and planname if not using testlink

if [ -z "$NumberOfNodes" ] || [ -z "$DockerPrefix" ] || [ -z "$ymlName" ] || [ -z "$gitRepo" ] || [ -z "$gitBranch" ] || [ -z "$drivertype" ] || [ -z "$environment" ] || [ -z "$projectname" ] || [ -z "$planname" ]
then
echo "ERROR :: ARGUMENT MISSING"
echo "Following Arguments are required : "
echo " 1) Number of Nodes to Generate(Node scale)"
echo " 2) Docker prefix(Selenium Grid Cluster naming)"
echo " 3) docker-compose.yml name(See Binding Field for more information)"
echo " 4) git repo url (Remove  'http://' from it)"
echo " 5) git branch name"
echo " 6) Test driver type"
echo " 7) Test Environment"
echo " 8) Test Project Name"
echo " 9) Test Plan Name"

exit 1
fi


#functioning block, to verify that we have free ram to create the containers on the server.
#echo "Arguments mapped.....Starting script................"


#removing prevoius junk reports
#replace jenkins with the username configured to connect with jenkins on the linux VM.
rm -rf /home/jenkins/results/$projectname/*


#Hard check on RAM sufficiency , will be deleted later after implementation of kubernetes.

NodesMemory=750
FreeMemory="$(free -m |awk '/Mem:/{print $4}')"
echo "**************Free RAM on this server is "$FreeMemory "****************************"
echo "**************Number of nodes that can be generated on this server are : "$(( $FreeMemory / $NodesMemory ))"*****************************"
echo "**************Your Execution would require approximately  "$(( $(($NumberOfNodes+1)) * $NodesMemory ))" MB of RAM resources *********************************"



if [ $(($FreeMemory / $NodesMemory)) -lt $(( $NumberOfNodes )) ]
then
        echo "***********Memory not available, please free memory resources**********"
        exit 1
else
echo "*****************Memory Available, creating Hub and Node containers*****************"
#echo "docker-compose -f $ymlName.yml -p $DockerPrefix up -d"

if [ "$drivertype" = "dockerff" ]
then

docker-compose -f ./firefoxFile/$ymlName.yml -p $DockerPrefix up -d
docker-compose -f ./firefoxFile/$ymlName.yml -p $DockerPrefix scale node=$NumberOfNodes
echo "*************Grid Cluster is Up**********************"
fi

if [ "$drivertype" = "dockerchrome" ]
then

docker-compose -f ./chromeFile/$ymlName.yml -p $DockerPrefix up -d
docker-compose -f ./chromeFile/$ymlName.yml -p $DockerPrefix scale node=$NumberOfNodes
echo "************Grid Cluster is Up********************"
fi

fi



#returning grid cluster name, IP and port number(replace 0.0.0.0 with your linux vm IP)

echo "***********Grid Cluster hub name is : "$DockerPrefix"_selenium-hub_1**************"
echo "***********Grid IP is :- http://0.0.0.0:"$(((docker ps|grep $DockerPrefix'_selenium-hub_1') | awk '{print $10}')|grep -Po '0.0.0.0:\K[^-]*')"/" " ************************************"



#Download Git repo , replace gitusername and gitpassword with your username and password

echo "Downloading Git Repo"
docker exec  $DockerPrefix'_selenium-hub_1' /bin/bash -c 'sudo chmod 777 -R /home/seluser/.m2/ && cd /home/seluser/AutomationProjects && git clone http://gitusername:gitpassword@'$gitRepo' -b '$gitBranch''


#getting the folder name of the project
foldername=$(docker exec  $DockerPrefix'_selenium-hub_1' /bin/bash -c 'cd /home/seluser/AutomationProjects && ls|awk 'NR==1 {print $1}' ')
#echo "folder name is "$foldername



echo "Number of Nodes" $NumberOfNodes 
echo "plan name is " $planname
echo "project name is" $projectname
echo "environment is " $environment
echo "drivertype is " $drivertype
echo "urlstr is "$urlstr

#execute mvn test command , you can type your custom command here.
echo "mvn clean test -Ddrivertype="$drivertype" -Denvironment="$environment" -Dprojectname="$projectname" -Dplanname="$planname" -Durlstr="$urlstr" -Djava.awt.headless=true -Dencoding=cp1252 -e"

#go to the project folder and execute the command
docker exec  $DockerPrefix'_selenium-hub_1' /bin/bash -c 'cd /home/seluser/AutomationProjects/'$foldername'&&pwd&& export nodecount='$NumberOfNodes' && mvn clean test -Ddrivertype='$drivertype' -Denvironment='$environment' -Dprojectname='$projectname' -Dplanname='$planname' -Durlstr='$urlstr' -Djava.awt.headless=true -Dencoding=cp1252 -e'

#get the reports from containers to the local Linux server/Linux VM
#replace jenkins with the username configured to connect with jenkins on the linux VM.

cd /home/jenkins/results
mkdir -p $projectname
cd $projectname
docker cp $DockerPrefix'_selenium-hub_1':/home/seluser/AutomationProjects/$foldername/target/surefire-reports/testng-results.xml .
docker cp $DockerPrefix'_selenium-hub_1':/home/seluser/AutomationProjects/$foldername/finalReport/ .


#ending the script
#echo "ending script.................."





