# each tag will create a docker image
docker build -f Dockerfile_base -t yingding/spark_base -t yingding/spark_base:0.0.1 .
docker build -f Dockerfile_master -t yingding/spark_master .
docker build -f Dockerfile_worker -t yingding/spark_worker .
docker build -f Dockerfile_submit -t yingding/spark_submit .
# docker build -f Dockerfile_submit -t sdesilva26/spark_submit -t sdesilva26/spark_submit:0.0.2 .
