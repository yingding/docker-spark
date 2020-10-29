# 1. Download the docker container and make a docker bridge network
docker network create --driver bridge spark-net-bridge

# 2. Start Docker Master on local port 8090, and 4041 to get the master log and job log:
# since the ENTRYPOINT is the /tini , thus we don't need to call docker with additional --init, otherwise two tini process will be started.
# Not using: docker run -dit --init --name spark-master --network spark-net-bridge -p 8090:8080 -p 4041:4040 yingding/spark_master:latest bash

docker run -dit --name spark-master --network spark-net-bridge -p 8090:8080 -p 4041:4040 yingding/spark_master:latest bash

# login to the container and run the following command to see the java process as PID 6 of /tini -v
ps -fA

# 3. Start Docker Worker on local port 8081 (also not calling --init from docker run, since the ENTRYPOINT is set to start from /tini)
# Not using: docker run -dit --init --name spark-worker1 --network spark-net-bridge -p 8081:8081 yingding/spark_worker:latest bash

docker run -dit --name spark-worker1 --network spark-net-bridge -p 8081:8081 yingding/spark_worker:latest bash

## Note of two level nested tini process ##
-i interactive
--init use /tini to pass the SIGTERM to the bash subprocess called from entrypoint.sh while passed as param for docker run.
Note:
using docker run --init, the ENTRYPOINT process will be wrapped unter tini -v as PID 6
Since we are using the ENTRYPOINT ["/tini", "-vv", "--", "/entrypoint.sh"] in Dockerfile.
While starting docker run with --init option may cause the docker run start PID 1 as tini -v process
and the container /tini --vv -- /entrypoint.sh will be start as PID 6 child process of PID 1 which is also "tini"
and the single executable will be started in our case the java process as the child process of PID 6 (level two tini)
This makes no sense to start two tini process nested. Thus, while ENTRYPOINT is the tini executable, the --init option
is not necessary any more.
(TODO need to test if it is also the case on the Ubuntu Server)
