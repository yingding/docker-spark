docker build -f Dockerfile_base -t yingding/spark_base -t yingding/spark_base:0.0.1 .
docker build -f Dockerfile_master -t sdesilva26/spark_master -t sdesilva26/spark_master:0.0.2 .
docker build -f Dockerfile_worker -t sdesilva26/spark_worker -t sdesilva26/spark_worker:0.0.2 .
docker build -f Dockerfile_submit -t sdesilva26/spark_submit -t sdesilva26/spark_submit:0.0.2 .
