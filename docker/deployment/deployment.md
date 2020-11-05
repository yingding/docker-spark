# Introduction into deploy container services with docker-compose

##1. Install docker-compose on Ubuntu Host
1. check if the docker-compose is installed on Ubutu host with `apt list | grep docker-compose` 
2. follow the instruction on https://docs.docker.com/compose/install/ for Linux installation with `curl` command to install docker-compose on Ubuntu and use root user to install
3. `groups <docker_user>` to see if your user is in the docker group
4. run with your `<docker_user>` the command `docker-compose --version`

###1.1 Fixing docker-compose takes a long time to do anything issue

Some times the docker-compose took very long to run. It may due to the [low entropy of your host](https://github.com/docker/compose/issues/6552). 
* check if your available entropy is blow 200 with `cat /proc/sys/kernel/random/entropy_avail`
* If that is the case install *haveged* random number generator with root user `apt install -y haveged`
* check your available entropy again with `cat /proc/sys/kernel/random/entropy_avail`, now you shall see the available entropy is over 1000

##2. docker-compose config file

##3. docker-compose file format and Docker compatibility
* Follow the link https://docs.docker.com/compose/compose-file/ to see the docker-compose file format with docker version compatibility.
* check the version of docker engine `docker version -f '{{.Server.Version}}'`
* The `version` attribute in docker-compose config file defines the file format.
* E.g. `version: "3.8"` of docker-compose config file will work with docker engine release `19.03.0+`.

##4. Create, start or restart container with docker-compose
* use `docker-compose -f MyFile.yml up -d` to create docker-compose container and also start the container, '-d' option is important otherwise the docker-compose starts the containers in the foreground.

###5. Stop and remove the container with docker-compose
* use `docker-compose -f MyFile.yml down -v` to stop and **delete** the container at the same time, `-v` option also removes the volume

###6. Just stop the container with docker-compose
* use `docker-compose -f MyFile.yml stop` to just stop the container, and container remains created.
* more details refer to https://nickjanetakis.com/blog/docker-tip-45-docker-compose-stop-vs-down

###7. Just start the container with docker-compose
* user `docker-compose -f MyFile.yml start` to just start the existing container, no containers will be created.
* more details refer to https://docs.docker.com/compose/faq/

### Further useful References for docker-compose: 
* https://www.ionos.com/community/server-cloud-infrastructure/docker/launch-and-orchestrate-docker-containers-with-docker-compose/
* https://vsupalov.com/flask-docker-compose-development-dependencies/
* https://nickjanetakis.com/blog/docker-tip-45-docker-compose-stop-vs-down
* https://docs.docker.com/compose/faq/
