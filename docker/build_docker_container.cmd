# 1. Download the docker container and make a docker bridge network
docker network create --driver bridge spark-net-bridge

# 2. Start Docker Master on local port 8090, and 4041 to get the master log and job log:
docker run -dit --init --name spark-master --network spark-net-bridge -p 8090:8080 -p 4041:4040 yingding/spark_master:latest bash

# 3. Start Docker Worker on local port 8081:
docker run -dit --init --name spark-worker1 --network spark-net-bridge -p 8081:8081 yingding/spark_worker:latest bash

## Note ##
-i interactive
--init use /tini to pass the SIGTERM to the bash subprocess called from entrypoint.sh
in this way the sh script can be called and ENV of bash will be evaluated. And the SIGTERM signal will be passed to /tini and forwarded to the single executable called in the entrypoint.sh shell script
