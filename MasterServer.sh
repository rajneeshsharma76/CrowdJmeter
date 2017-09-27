#!/bin/bash
docker build -t jmeter . -f  Dockerfile-server
#Stop and Remove If Conatianer Exits To cretae new Docker Container

docker stop jmeterserver jmeter1 jmeter2
docker rm jmeterserver jmeter1 jmeter2
docker run -d  -it  --name jmeterserver floodio/jmeter&&docker run -d  -it  --name jmeter1 floodio/jmeter && docker run -d  -it  --name jmeter2 floodio/jmeter
###################################################################################################
docker cp jmeterserver:/jmeter/bin/jmeter.properties .
IPSlave1=$(docker inspect -f '{{ .NetworkSettings.IPAddress }}' jmeter1 2>&1)
IPslave2=$(docker inspect -f '{{ .NetworkSettings.IPAddress }}' jmeter2 2>&1)
sed -i "/remote_hosts=/ s/=/=$IPSlave1,$IPslave2,/" jmeter.properties
##############################################################

docker stop jmeterserver jmeter1 jmeter2
docker rm jmeterserver jmeter1 jmeter2

docker build -t jmeter . -f  Dockerfile-server
sleep 5
docker run -d  -it  --name jmeterserver jmeter
sleep 5
docker run -d -p 1098 -it  --name jmeter1 jmeter /usr/bin/jstatd -J-Djava.security.policy=/jmeter/bin/jstatd.all.policy -J-Djava.rmi.server.hostname=$IPSlave1 -p 1098 &
sleep 5
docker run -d -p 1098 -it  --name jmeter2 jmeter /usr/bin/jstatd -J-Djava.security.policy=/jmeter/bin/jstatd.all.policy -J-Djava.rmi.server.hostname=$IPSlave2 -p 1098 &
#docker run -d  -it  --name jmeter2 jmeter

docker cp jmeter.properties jmeterserver:/jmeter/bin
#docker cp TaskForce.jmx jmeterserver:/jmeter/bin
#docker cp taskforce.csv jmeterserver:/jmeter/bin
sleep 5
####################Changing Local RMI Port of client to avoid Firewall Issue##################
rm -r jmeter.properties
docker cp jmeter1:/jmeter/bin/jmeter.properties .
sed -i '/server.rmi.localport/s/^#//g' jmeter.properties
sed -i 's/server.rmi.localport=1234/server.rmi.localport=4000/' jmeter.properties
docker cp jmeter.properties jmeter1:/jmeter/bin/
docker cp jmeter.properties jmeter2:/jmeter/bin/
rm -r jmeter.properties
#####################################################################################################
docker exec -i jmeter1 /jmeter/bin/jmeter-server &
sleep 5
docker exec -i jmeter2 /jmeter/bin/jmeter-server &
sleep 5
docker exec -i jmeterserver /jmeter/bin/jmeter -n -t /jmeter/bin/TaskForce.jmx -R $IPSlave1,$IPslave2 -l /jmeter/bin/PerfReport.jtl
sleep 5
docker cp jmeterserver://jmeter/bin/PerfReport.jtl .
