# Following build command create in the repository "yingding/spark_base" a tag latest and a tag 0.0.1 two images
# docker build -f Dockerfile_base -t yingding/spark_base -t yingding/spark_base:0.0.1 .
# Every tag declared during the build process will create a docker image on the local disk
# use "docker image rm <imageId1> <imageId2>" to remove images
docker build -f Dockerfile_base -t yingding/spark_base -t yingding/spark_base:0.0.3 .
docker build -f Dockerfile_master -t yingding/spark_master -t yingding/spark_master:0.0.3 .
docker build -f Dockerfile_worker -t yingding/spark_worker -t yingding/spark_worker:0.0.3 .
docker build -f Dockerfile_submit -t yingding/spark_submit -t yingding/spark_submit:0.0.3 .

