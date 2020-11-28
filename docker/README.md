# 1. Quick Start for docker and docker-compose 

This documentation gives a short introduction of using the spark with docker, and docker-compose in Linux or Macosx. It is assumed that docker and docker-compose are already instead successfully on your system before executing the following commands. 

## 1.1 Create images on your system
* check out this repository and go to the docker sub-folder.
```
cd <path to repo root>/docker-spark/docker
```
#### 1.1.1 Build base image
```
docker build -f Dockerfile_base -t yingding/spark_base .
```
this command will create an image named `yingding/spark_base:latest`

#### 1.1.2 Build master node image
```
docker build -f Dockerfile_master -t yingding/spark_master .
```
this command will create an image named `yingding/spark_master:latest`

#### 1.1.3 Build worker node image
```
docker build -f Dockerfile_worker -t yingding/spark_worker .
```
this command will create an image named `yingding/spark_worker:latest`

## 1.2 Deploy containers with docker-compose
Note: docker-compose shall be installed on your system before you execute the following commandlines, following [deployment.md](deployment.md) to install and config docker-compose on your ubuntu system.

#### 1.2.1 Create and start containers
``` 
cd <path to repo root>/docker-spark/docker/deployment
docker-compose -f docker-compose-standalone-desktop.yml up -d
```

#### 1.2.2 Inspect containers and networks
```
docker ps -a
docker network ls
docker network inspect docker_spark-net
```
these commands show all created containers, and all networks associated with docker. It also shows the details of a particular network called `docker_spark-net`, to which all spark master and workder containers are associated.

 
## 1.3 Play around with Spark Stand-alone Cluster

Spark driver is a node (or a program) which contains your program code and send it as file to the spark master node for execution. Alternatively Spark driver can also communicate with Spark master node through remote procedure calls (RPC).

#### 1.3.1 Start a second process in the container of spark master 
```
sudo docker exec -it docker_spark-master_1 /bin/bash
```
this command starts a second process inside the spark master container. This way we save some memory for starting an additional spark-submit container for emulating a Spark driver node. In reality, you may have a separate java/scala/python program which will function as a spark driver.

#### 1.3.2 Start an interative spark scala shell
Type in the previous bash tty starts for the spark master node the following command.
```
$SPARK_HOME/bin/spark-shell --conf spark.executor.memory=1G --conf spark.executor.cores=1 --master spark://spark-master:7077 --packages org.mongodb.spark:mongo-spark-connector_2.12:3.0.0
```
you may remove the `--packages` option, shall you do not need to use additional package for your code submitted through spark driver. In this example, i added an additional mongo-spark-connector` lib to the interactive spark shell.

#### 1.3.3 Programming inside spark shell
Type the following scala code in your spark scala shell to test the Spark Cluster, you shall see the output value `5000`.

```scala
val myRange = spark.range(10000).toDF("number")

val divisBy2 = myRange.where("number % 2 = 0")

divisBy2.count()
```

#### 1.3.4 Examing the logs of spark cluster
* Open in your browser http://localhost:8080 to see the log for spark-master_1
* Open in your browser http://localhost:8081 to see the log of spark-worker_1
* Open in your browser http://localhost:8082 to see the log of spark-worker_2
* Open in your browser http://localhost:4040 to see the log of spark driver. The driver log is available as long as the spark interactive shell is still open.

#### 1.3.5 Log out spark shell
```
:q
```
log out from the spark shell with "colon" and "q", after this the driver WEBUI (http://localhost:4040) is NOT accessable anymore.

#### 1.3.6 Exit from your docker tty
```
exit
```

## 1.4 Administrate deployed containers with docker-compose

#### 1.4.1 stop containers (no remove of containers)
```
cd <path to repo root>/docker-spark/docker/deployment

docker-compose -f docker-compose-standalone-desktop.yml stop
```

#### 1.4.2 start created containers
```
docker-compose -f docker-compose-standalone-desktop.yml start
```

#### 1.4.3 stop and remove all spark containers
```
docker-compose -f docker-compose-standalone-desktop.yml down
```

## 1.5 remove docker images
* use `docker images` to show all available docker images and examine the image ids
* use docker image rm <imageId1> <imageId2>` to remove all spark images (base, master, worker)


# 2. Quick Start for k8s and Podman

Please stay tuned for further information about using spark-container with kubernetes(k8s) and podman. 

## References
* podman http://docs.podman.io/en/latest/
* Introduction of Kubernetes (k8s): https://youtu.be/daVUONZqn88


