# Binding is no more a mandatory parameter , you can remove it , from here and from jenkins configuration
Binding=$1
Docker_Prefix=$2

if [ -z "$Docker_Prefix" ] || [ -z "$Binding" ]

then
echo "Two arguments are required"
echo "1) Binding"
echo "2) DockerPrefix"

exit 1

fi


cd /home/jenkins/dockergrid
docker-compose -p $Docker_Prefix down
