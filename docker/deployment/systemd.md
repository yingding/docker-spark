# Introduction of systemd
## creat the container first
* sparkd.sh doesn't create the container, it only start/stop the container service defined in your own docker-compose config file
* create your container with `docker-compose -f MyConfig.yml up -d`

## customize sparkd.sh script
* change the variable `COMPOSE_CONFIG_DIR` to match the location of your own docker-compose config yml file
* cahnge the variable `COMPOSE_FILE_NAME` to match the file name of your own docker-compose config yml file

## Add sparkd to init.d
use `sudo cp sparkd.sh /etc/init.d/sparkd`

## Make the spard executable
use `sudo chmod 755 /etc/init.d/sparkd`

## Activate spard for run level files on ubuntu
Notice reload doesn't work for a none native service
use `sudo systemctl disable sparkd`
use `sudo systemctl enable sparkd`

## Testing 
`service sparkd status`
`service sparkd stop`
`service sparkd start`

## Test through restart server
`shutdown -r now`
