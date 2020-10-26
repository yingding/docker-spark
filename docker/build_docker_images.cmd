# each tag will create a docker image
# Folgende build create in repository yingding/spark_base a tag latest and a tag 0.0.1 two images
# docker build -f Dockerfile_base -t yingding/spark_base -t yingding/spark_base:0.0.1 .
docker build -f Dockerfile_base -t yingding/spark_base .
docker build -f Dockerfile_master -t yingding/spark_master .
docker build -f Dockerfile_worker -t yingding/spark_worker .
docker build -f Dockerfile_submit -t yingding/spark_submit .

